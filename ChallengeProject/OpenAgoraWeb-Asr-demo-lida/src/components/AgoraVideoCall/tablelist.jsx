import React from 'react';
import { Table } from 'antd';

const { Column, ColumnGroup } = Table;

const TableList = ({data, exitOne})=> {
    return (
        <Table bordered dataSource={data}>
            <Column title="角色" dataIndex="uid" key="uid" />
            <Column title="音频设备" dataIndex="microphoneName" key="microphoneName" />
            <Column title="视频设备" dataIndex="cameraName" key="cameraName"  />
                
            {/* <Column
            title="操作"
            key="action"
            colSpan={4}
            render={(text, record) => (
                <span>
                <a href="javascript:;" onClick={()=> this.exitOne(record)}>退出会议</a>
                
                </span>
            )}
            /> */}
        </Table>
    )
}

export default TableList