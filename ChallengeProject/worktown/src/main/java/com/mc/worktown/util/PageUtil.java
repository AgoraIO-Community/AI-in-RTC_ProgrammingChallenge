package com.mc.worktown.util;

import com.mc.worktown.model.SearchModel;
import com.mc.worktown.model.SearchResultModel;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.lang.reflect.InvocationTargetException;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * 分页工具
 *
 * @author malin
 * @version 1.0
 */
@Slf4j
public class PageUtil {

    /**
     * 判断是否分页
     *
     * @param searchInfo 查询信息
     * @return 判断结果
     */
    public static boolean isPaged(SearchModel searchInfo) {
        return searchInfo.getPageSize() > 0;
    }

    /**
     * 判断是否排序
     *
     * @param searchInfo 查询信息
     * @return 判断结果
     */
    public static boolean isSorted(SearchModel searchInfo) {
        return StringUtils.isNotBlank(searchInfo.getSort());
    }

    /**
     * 取得分页信息
     *
     * @param searchInfo 查询信息
     * @param sortInfo   排序信息
     * @return 分页信息
     */
    public static Pageable getPageInfo(SearchModel searchInfo, Sort sortInfo) {
        if (PageUtil.isPaged(searchInfo)) {
            return PageRequest.of(searchInfo.getPageIndex(), searchInfo.getPageSize(), sortInfo);
        } else {
            return Pageable.unpaged();
        }
    }

    /**
     * 取得排序信息
     *
     * @param searchInfo 查询信息
     * @return 排序信息
     */
    public static Sort getSortInfo(SearchModel searchInfo) {
        if (PageUtil.isSorted(searchInfo)) {
            if (searchInfo.isAsc()) {
                return new Sort(Sort.Direction.ASC, searchInfo.getSort());
            } else {
                return new Sort(Sort.Direction.DESC, searchInfo.getSort());
            }
        } else {
            return Sort.unsorted();
        }
    }

    /**
     * 取得真实的当前页索引
     *
     * @param searchInfo 查询信息
     * @param total      元素总数
     * @return 真实的当前页索引
     */
    public static Optional<Integer> getRealIndex(SearchModel searchInfo, int total) {
        if (!isPaged(searchInfo)) {
            return Optional.empty();
        }

        int totalPage = total / searchInfo.getPageSize();
        totalPage = total % searchInfo.getPageSize() == 0 ? totalPage : totalPage + 1;

        log.debug("total={}, pageSize={}, totalPage={}", total, searchInfo.getPageSize(), totalPage);

        int newIndex = searchInfo.getPageIndex() < totalPage ? searchInfo.getPageIndex() : totalPage - 1;
        newIndex = newIndex > 0 ? newIndex : 0;

        log.debug("pageIndex={}, totalPage={}, newPageIndex={}", searchInfo.getPageIndex(), totalPage, newIndex);

        return newIndex == searchInfo.getPageIndex() ? Optional.empty() : Optional.of(newIndex);
    }

    /**
     * 按排序方法进行排序、返回查询结果信息
     *
     * @param searchInfo  查询信息
     * @param allItemList 全部内容列表
     * @param comparator  排序方法
     * @return 查询结果信息
     */
    public static <T> SearchResultModel<T> getSearchResult(
            SearchModel searchInfo, List<T> allItemList, Comparator<T> comparator) {
        SearchResultModel<T> model = new SearchResultModel<>();
        model.setSize(searchInfo.getPageSize());
        model.setTotal(allItemList.size());

        if (Objects.nonNull(comparator)) {
            allItemList.sort(comparator);
        }

        if (PageUtil.isPaged(searchInfo)) {
            model.setIndex(getRealIndex(searchInfo, allItemList.size()).orElse(searchInfo.getPageIndex()));
            int start = model.getIndex() * model.getSize();
            int end = start + model.getSize();

            log.debug("start={}, end={}", start, end);

            if (end >= model.getTotal()) {
                model.setItems(allItemList.subList(start, model.getTotal()));
            } else {
                model.setItems(allItemList.subList(start, end));
            }
        } else {
            model.setIndex(0);
            model.setItems(allItemList);
        }

        return model;
    }

    /**
     * 按查询信息中排序字段和是否正序进行排序、返回查询结果信息
     *
     * @param searchInfo  查询信息
     * @param allItemList 全部内容列表
     * @return 查询结果信息
     */
    public static <T> SearchResultModel<T> getSearchResult(SearchModel searchInfo, List<T> allItemList) {
        if (!PageUtil.isSorted(searchInfo)) {
            return getSearchResult(searchInfo, allItemList, null);
        }

        return getSearchResult(searchInfo, allItemList,
                (item1, item2) -> {
                    String value1 = getSortValue(item1, searchInfo.getSort());
                    String value2 = getSortValue(item2, searchInfo.getSort());
                    int compare = value1.compareTo(value2);
                    return searchInfo.isAsc() ? compare : -compare;
                });
    }

    /**
     * 映射查询结果信息
     *
     * @param resultInfo 查询结果信息
     * @param mapper     映射器
     * @return 映射后的查询结果信息
     */
    public static <T, R> SearchResultModel<R> mapSearchResult(SearchResultModel<T> resultInfo, Function<T, R> mapper) {
        SearchResultModel<R> model = new SearchResultModel<>();
        model.setIndex(resultInfo.getIndex());
        model.setSize(resultInfo.getSize());
        model.setTotal(resultInfo.getTotal());
        model.setItems(resultInfo.getItems().stream().map(mapper).collect(Collectors.toList()));

        return model;
    }

    /**
     * 取得排序用的值
     *
     * @param object       排序对象
     * @param sortProperty 对象属性
     * @return 排序用的值
     */
    public static String getSortValue(Object object, String sortProperty) {
        try {
            Object value = MethodUtils.invokeMethod(object, "get" + StringUtils.capitalize(sortProperty));
            return value == null ? "" : value.toString();
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }
}
