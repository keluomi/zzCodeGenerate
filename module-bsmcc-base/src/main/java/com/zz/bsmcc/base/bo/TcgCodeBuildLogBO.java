package com.zz.bsmcc.base.bo;

import com.zz.bsmcc.base.domain.TcgCodeBuildLogEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.zz.bms.annotaions.EntityAnnotation;

import java.io.Serializable;



/**
* 代码生成记录 BO , 扩展 代码生成记录Entity对象
* @author Administrator
*/
@EntityAnnotation(value="代码生成记录" , resource = "")
@TableName(value="tcg_code_build_log" , resultMap = "TcgCodeBuildLogResultMap")
public class TcgCodeBuildLogBO extends TcgCodeBuildLogEntity implements Serializable {

    private String projectName;
    private String templetGroupName;

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getTempletGroupName() {
        return templetGroupName;
    }

    public void setTempletGroupName(String templetGroupName) {
        this.templetGroupName = templetGroupName;
    }
}
