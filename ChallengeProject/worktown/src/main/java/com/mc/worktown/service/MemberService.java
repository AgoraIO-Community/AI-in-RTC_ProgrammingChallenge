package com.mc.worktown.service;

import com.mc.worktown.entity.MemberEntity;
import com.mc.worktown.model.SearchMemberModel;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户Service
 *
 * @author malin
 * @version 1.0
 */
@Service
public class MemberService extends BaseRepositoryService<MemberEntity> {

    /**
     * 根据登录名取得用户信息
     *
     * @param loginName 登录名
     * @return 用户信息
     */
    public MemberEntity getOneByLoginName(String loginName) {
        // 设置查询条件
        Specification<MemberEntity> spec = (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.<String>get("loginName"), loginName);

        // 查询
        return repository.findOne(spec).orElse(null);
    }

    /**
     * 查询用户
     *
     * @param condition 查询条件
     * @return 用户列表
     */
    public List<MemberEntity> search(SearchMemberModel condition) {

        Specification<MemberEntity> spec = (root, query, criteriaBuilder) -> {
            List<Predicate> predicateList = new ArrayList<>();
            if (StringUtils.isNotBlank(condition.getLoginName())) {
                predicateList.add(criteriaBuilder.equal(root.<String>get("loginName"), condition.getLoginName()));
            }
            if (StringUtils.isNotBlank(condition.getName())) {
                predicateList.add(criteriaBuilder.equal(root.<String>get("name"), condition.getName()));
            }
            if (StringUtils.isNotBlank(condition.getTeamCode())) {
                predicateList.add(criteriaBuilder.equal(root.<String>get("teamCode"), condition.getTeamCode()));
            }

            return criteriaBuilder.and(predicateList.toArray(new Predicate[0]));
        };

        List<MemberEntity> rst = repository.findAll(spec);
        // 查询
        return rst;
    }
}
