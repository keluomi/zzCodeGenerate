package com.zz.bsmcc.base.bo;

import com.baomidou.mybatisplus.annotations.TableField;
import com.zz.bsmcc.base.domain.TcgExColumnEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.zz.bms.annotaions.EntityAnnotation;

import java.io.Serializable;



/**
* 扩展列设置 BO , 扩展 扩展列设置Entity对象
* @author Administrator
*/
@EntityAnnotation(value="扩展列设置" , resource = "")
@TableName(value="tcg_ex_column" , resultMap = "TcgExColumnResultMap")
public class TcgExColumnBO extends TcgExColumnEntity implements Serializable {



    @TableField(exist = false)
    private String originalColumnName;


    @TableField(exist = false)
    private String originalJavaName;


    @TableField(exist = false)
    private String originalColumnFk;

    @TableField(exist = false)
    private String originalColumnDict;

    //@EntityAttrAnnotation(attrName="组编码",sort=11  , attrLength=50    )
    //一般相同的数据项用相同的组名 ， 比如在项目表中， 客户名称，客户编号， 客户电话 ，客户ID等
    @TableField(exist = false)
    private String groupCode;

    //@EntityAttrAnnotation(attrName="字典类型",sort=12  , attrLength=50    )
    @TableField(exist = false)
    private String dictType;


    @TableField(exist = false)
    private String originalColumnFkName ;

    @TableField(exist = false)
    private String originalColumnDictName;


    //用于生成代码

    @TableField(exist = false)
    private String fkJavaName;

    //对应的原始列
    @TableField(exist = false)
    private TcgColumnConfigBO  originalColumn;


    public String getOriginalColumnName() {
        return originalColumnName;
    }

    public void setOriginalColumnName(String originalColumnName) {
        this.originalColumnName = originalColumnName;
    }

    public String getOriginalJavaName() {
        return originalJavaName;
    }

    public void setOriginalJavaName(String originalJavaName) {
        this.originalJavaName = originalJavaName;
    }

    public String getOriginalColumnFk() {
        return originalColumnFk;
    }

    public void setOriginalColumnFk(String originalColumnFk) {
        this.originalColumnFk = originalColumnFk;
    }

    public String getOriginalColumnDict() {
        return originalColumnDict;
    }

    public void setOriginalColumnDict(String originalColumnDict) {
        this.originalColumnDict = originalColumnDict;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }

    public String getDictType() {
        return dictType;
    }

    public void setDictType(String dictType) {
        this.dictType = dictType;
    }

    public String getOriginalColumnFkName() {
        return originalColumnFkName;
    }

    public void setOriginalColumnFkName(String originalColumnFkName) {
        this.originalColumnFkName = originalColumnFkName;
    }

    public String getOriginalColumnDictName() {
        return originalColumnDictName;
    }

    public void setOriginalColumnDictName(String originalColumnDictName) {
        this.originalColumnDictName = originalColumnDictName;
    }

    public String getFkJavaName() {
        return fkJavaName;
    }

    public void setFkJavaName(String fkJavaName) {
        this.fkJavaName = fkJavaName;
    }

    public TcgColumnConfigBO getOriginalColumn() {
        return originalColumn;
    }

    public void setOriginalColumn(TcgColumnConfigBO originalColumn) {
        this.originalColumn = originalColumn;
    }
}
