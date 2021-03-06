<style lang="less">

</style>

<template>
    <div class="page-body">

        <table-list :columns="columns" :tableData="data" :total="total" :loading="loading" @selectionChange="selectionChange" @callback="callback">
        <#if querys?exists >
            <div slot="form">
                <#list querys as being>
                    <#if project.queryMode == 'toolbar' >
                        <!-- 工具栏 方式 -->
                        <FormItem   <#if (being.queryTitle?exists) && (being.queryTitle?length > 0) > label="${being.queryTitle}" </#if> >

                            <#if being.columnPage?exists && being.columnPage.columnConfig?exists>
                                <#if being.columnPage.element == 'input' >
                                    <Input type="text" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'digits' >
                                    <InputNumber  v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'number' >
                                    <InputNumber  v-model="searchForm.${being.columnPage.columnConfig.javaName}"  precision="2" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'date' >
                                    <DatePicker type="date"   v-model="searchForm.${being.columnPage.columnConfig.javaName}"  clearable editable="false" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'timestamp' >
                                    <DatePicker type="datetime"   v-model="searchForm.${being.columnPage.columnConfig.javaName}"  clearable editable="false" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'email' >
                                    <Input type="email" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'url' >
                                    <Input type="url" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />

                                <#elseif being.columnPage.element == 'radio' >
                                    <RadioGroup v-model="searchForm.${being.columnPage.columnConfig.javaName}">
                                        <Radio v-for="(item, index) in ${being.columnPage.columnConfig.dictType}s" :label="item.dictVal" :key="item.dictVal">
                                            <span>{{item.dictName}}</span>
                                        </Radio>
                                    </RadioGroup>

                                <#elseif being.columnPage.element == 'checkbox' >
                                    <CheckboxGroup  v-model="searchForm.${being.columnPage.columnConfig.javaName}">
                                        <Checkbox  v-for="(item, index) in ${being.columnPage.columnConfig.dictType}s" :label="item.dictVal" :key="item.dictVal">
                                            <span>{{item.dictName}}</span>
                                        </Checkbox >
                                    </CheckboxGroup >



                                <#elseif being.columnPage.element == 'select' >
                                    <Select v-model="searchForm.${being.columnPage.columnConfig.javaName}" placeholder="${being.queryPlaceholder}" style="width: 200px">
                                        <Option value="">所有</Option>
                                        <Option v-for="(item, index) in ${being.columnPage.columnConfig.dictType}s" :value="item.dictVal" :key="item.dictVal" >{{item.dictName}}</Option>
                                    </Select>

                                <#elseif being.columnPage.element == 'openwin' >
                                    <Input v-model="searchForm.${being.columnPage.columnConfig.javaName}Name"   style="width: 200px;margin-left: 7px" @on-focus="select_${being.columnPage.columnConfig.javaName}_${being.columnPage.columnConfig.originalColumn.fkTableConfig.javaName}"/>

                                <#else >
                                    <Input type="text" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                </#if>
                            <#elseif being.columnPage?exists && being.columnPage.exColumn?exists>
                                <#if being.columnPage.element == 'openwin' >
                                    <Input v-model="searchForm.${being.columnPage.exColumn.javaName}"   style="width: 200px;margin-left: 7px" @on-focus="select_${being.columnPage.exColumn.javaName}_${being.columnPage.exColumn.originalColumn.fkTableConfig.javaName}"/>
                                </#if>
                            <#else>
                                <Input type="text" v-model="searchForm.${being.queryFieldName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                            </#if>
                        </FormItem>
                    <#elseif project.queryMode == 'ordinary'>
                        <!-- 一个查询条件占一行 方式 -->

                        <#if being.columnPage?exists && being.columnPage.columnConfig?exists>

                            <#if being.columnPage.element == 'select' || being.columnPage.element == 'checkbox' || being.columnPage.element == 'radio'>
                                <${being.columnPage.columnConfig.javaName}Dict label="<#if (being.queryTitle?exists) && (being.queryTitle?length > 0) > label="${being.queryTitle}" </#if>" :selectData="${being.columnPage.columnConfig.dictType}s"  v-model="searchForm.${being.columnPage.columnConfig.javaName}"  @change="findList" />
                            <#elseif being.columnPage.element == 'openwin' >
                                <Input v-model="searchForm.${being.columnPage.columnConfig.javaName}Name"   style="width: 200px;margin-left: 7px" @on-focus="select_${being.columnPage.columnConfig.javaName}_${being.columnPage.columnConfig.originalColumn.fkTableConfig.javaName}"/>
                            <#else>
                                <#if being.columnPage.element == 'input' >
                                    <Input type="text" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'digits' >
                                    <InputNumber  v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'number' >
                                    <InputNumber  v-model="searchForm.${being.columnPage.columnConfig.javaName}"  precision="2" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'date' >
                                    <DatePicker type="date"   v-model="searchForm.${being.columnPage.columnConfig.javaName}"  clearable editable="false" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'timestamp' >
                                    <DatePicker type="datetime"   v-model="searchForm.${being.columnPage.columnConfig.javaName}"  clearable editable="false" style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'email' >
                                    <Input type="email" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                <#elseif being.columnPage.element == 'url' >
                                    <Input type="url" v-model="searchForm.${being.columnPage.columnConfig.javaName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                                </#if>
                            </#if>
                        <#elseif being.columnPage?exists && being.columnPage.exColumn?exists>
                            <#if being.columnPage.element == 'openwin' >
                                <Input v-model="searchForm.${being.columnPage.exColumn.javaName}"   style="width: 200px;margin-left: 7px" @on-focus="select_${being.columnPage.exColumn.javaName}_${being.columnPage.exColumn.originalColumn.fkTableConfig.javaName}"/>
                            </#if>
                        <#else>
                            <Input type="text" v-model="searchForm.${being.queryFieldName}"   style="width: 200px;margin-left: 7px" placeholder="${being.queryPlaceholder}" />
                        </#if>
                    <#else>
                        //todo 项目的查询方式设置错误， 或者有新的选项添加没有及时处理
                    </#if>

                </#list>
            </div>
        </#if>

        <div slot="toolbar">
            <#list operations as operation>
                <#if operation.position?exists && operation.position == 'top' || operation.position == 'all'>
                    <Button type="success"  title="${operation.operationName}"
                        <#if operation.icons?exists>icon="${operation.icons}"</#if>
                        <#if operation.styles?exists >style="${operation.styles}"</#if>
                        <#if operation.classs?exists>class="${operation.classs}"</#if>
                    <#if operation.operationBO?exists && operation.operationBO.opMode == '1' >
                        @click="showDialog('${operation.operationName}',${operation.operationBO.selectMode},'<#if operation.operationResource == 'add' || operation.operationResource == 'update'>edit<#else >${operation.operationResource}</#if>')"
                    <#else>
                        @click="${operation.operationResource}"
                    </#if>
                        v-show="permissions.includes('${table.fullResourceFile}:${operation.operationResource}')">${operation.operationName}</Button>
                </#if>
            </#list>
        </div>
        </table-list>





    <#list operations as operation>
    <#if operation.operationResource == 'add' || operation.operationResource == 'update'>
    <${table.javaName}Edit @saveSuccess="saveSuccess('edit')"  :title="title"  ref="editRef" :display="editDisplay" />
    <#break>
    </#if>
    </#list>


    <#list operations as operation>
        <#if operation.operationResource == 'detail'>
            <${table.javaName}Detail :title="title"  @closeDialog="closeDialog('detail')" ref="detailRef" :display="detailDisplay" />
            <#break>
        </#if>
    </#list>


    <#list operations as operation>
        <#if operation.operationBO?exists && operation.operationBO.opMode == '1' >
            <#if operation.operationResource != 'add' && operation.operationResource != 'update'  && operation.operationResource != 'detail'>
            <${table.javaName}${operation.operationResource?cap_first} @saveSuccess="saveSuccess('${operation.operationResource}')"  :title="title"   ref="${operation.operationResource}Ref" :display="${operation.operationResource}Display" />
            </#if>
        </#if>
    </#list>



    <#list queryFkTables as fkTable>
        <${fkTable.javaName}Search title="选择${fkTable.tableComment}" :display="select${fkTable.javaName}Display" :type="type"
                                           <#list queryFks[fkTable.fullResourceFile] as queryField >
                                           @on-selected-${queryField.columnPage.javaName}="selected${queryField.columnPage.javaName}Fun"
                                           </#list>
        />

    </#list>

    </div>
</template>

<script>
    import ${table.javaName}Api from '@/api/${table.fullResourceFile}/${table.javaName}Api' ;




    <#list operations as operation>
        <#if operation.operationResource == 'add' || operation.operationResource == 'update'>
        import ${table.javaName}Edit from './${table.javaName}Edit' ;
            <#break>
        </#if>
    </#list>

    <#list operations as operation>
        <#if operation.operationResource == 'detail'>
        import ${table.javaName}Detail from './${table.javaName}Detail' ;
            <#break>
        </#if>
    </#list>






    <#list operations as operation>
        <#if operation.operationBO?exists && operation.operationBO.opMode == '1' >
            <#if operation.operationResource != 'add' && operation.operationResource != 'update' && operation.operationResource != 'detail'>

            import ${table.javaName}${operation.operationResource?cap_first} from './${table.javaName}${operation.operationResource?cap_first}' ;
            </#if>
        </#if>
    </#list>




    import tableList from '@/components/table-list/tableList'
    import tableMix from '@/mixins/tableMix'
    import timeFormat from '@/utils/timeformat';
    <#if project.queryMode == 'ordinary' >
    import selectSpan from '@/components/select-span/select-span';
    import dialog from '@/utils/dialog'
    </#if>

    <#list queryFkTables as fkTable>
    import ${fkTable.javaName}Search from '@/views/${fkTable.fullResourceName}/${fkTable.javaName}Search'
    </#list>

    export default {
        name: '${table.javaName}List',
        components: {




    <#list operations as operation>
        <#if operation.operationResource == 'add' || operation.operationResource == 'update'>

            ${table.javaName}Edit,
            <#break>
        </#if>
    </#list>

    <#list operations as operation>
        <#if operation.operationResource == 'detail'>
        ${table.javaName}Detail,
        <#break>
        </#if>
    </#list>



    <#list operations as operation>
        <#if operation.operationBO?exists && operation.operationBO.opMode == '1' >
            <#if operation.operationResource != 'add' && operation.operationResource != 'update' && operation.operationResource != 'detail'>

                ${table.javaName}${operation.operationResource?cap_first} ,
            </#if>
        </#if>
    </#list>

            tableList,
            <#list queryFkTables as fkTable>
                ${fkTable.javaName}Search <#if fkTable_has_next>,</#if>
            </#list>
            <#if project.queryMode == 'ordinary' >
                <#list queryDicts as dict>
                    ${dict.columnPage.columnConfig.javaName}Dict : selectSpan,
                </#list>
            </#if>

        },
        mixins:[tableMix],
        data () {
            return {
                ${table.javaName}: {},
                    detailDisplay: false,
                    editDisplay: false,
    <#list operations as operation>
        <#if operation.operationBO?exists && operation.operationBO.opMode == '1' >
            <#if operation.operationResource != 'add' && operation.operationResource != 'update' && operation.operationResource != 'detail'>
                    ${operation.operationResource}Display: false,
            </#if>
        </#if>
    </#list>
                <#list queryFkTables as fkTable>
                    select${fkTable.javaName}Display: false,
                </#list>

                type: '',
                searchForm:{
                    <#list querys as being >
                    <#if being.columnPage?exists>
                    <#if being.columnPage.element == 'openwin'>
                        <#if being.columnPage.exColumn?exists>
                        ${being.columnPage.exColumn.originalColumn.javaName},
                        <#else>
                        ${being.columnPage.columnConfig.originalColumn.javaName},
                        </#if>
                    </#if>
                    ${being.columnPage.javaName}<#if fkTable_has_next>,</#if>
                    <#else>
                    ${being.queryFieldName}<#if fkTable_has_next>,</#if>
                    </#if>
                    </#list>
                },
            <#list queryDictSet as queryColumn>
                <#if queryColumn.columnPage.exColumn?exists>${queryColumn.columnPage.exColumn.dictType}Dict : [],
                <#else>that.${queryColumn.columnPage.columnConfig.dictType}Dict :[],
                </#if>
            </#list>
                columns: [
                    {
                        title: '序号',
                        type: 'selection',
                        width: 80,
                        fixed: 'left',
                        align: 'center'
                    },
                    <#list listColumnPages as page>
                        {
                            title: '<#if page.columnConfig?exists>${page.columnConfig.columnComment}<#else >${page.exColumn.columnTitle}</#if>',
                            key: '<#if page.columnConfig?exists>${page.columnConfig.javaName}<#else >${page.exColumn.javaName}</#if>',
                            fixed: 'left',
                            align: 'center',
                            width: 150
                        }<#if page_has_next>,</#if>
                    </#list>

                ]
            };
        },



        methods: {

            <#list queryFks?values as queryFkList >
            <#list queryFkList as queryField >
                selected${queryField.columnPage.javaName}Fun(selection){
                    <#if queryField.columnPage.exColumn?exists>
                        this.searchForm.${queryField.columnPage.exColumn.originalColumn.javaName} = selection.id;
                        this.searchForm.${queryField.javaName} = selection.${queryField.columnPage.exColumn.fkJavaName};
                    <#else >
                        this.searchForm.${queryField.columnPage.columnConfig.originalColumn.javaName} = selection.id;
                        this.searchForm.${queryField.javaName} = selection.${queryField.columnPage.columnConfig.fkJavaName};
                    </#if>
                    this.selectDisplay = false;

                },
            </#list>
            </#list>

        <#list querys as being>
            <#if being.columnPage?exists && being.columnPage.element == 'openwin' >
                <#if being.columnPage.columnConfig?exists>
                <#elseif  being.columnPage.exColumn?exists>
                select_${being.columnPage.exColumn.javaName}_${being.columnPage.exColumn.originalColumn.fkTableConfig.javaName}{

                    this.type='${being.columnPage.javaName}';
                    this.select${being.columnPage.exColumn.originalColumn.fkTableConfig.javaName}Display = true ;
                }
                </#if>
            </#if>
        </#list>

<#list operations as operation>
    <#if operation.operationBO?exists && operation.operationBO.opMode != '1' >
    ${operation.operationResource}(){
        let that = this;


        <#if operation.operationBO.selectMode == '2' >
        if (this.selectedIds.length <1){
            dialog.warning('请选择要操作的数据!',that);
            return ;
        }
        <#elseif operation.operationBO.selectMode == '1' >
            if (this.selectedIds.length <1){
                dialog.warning('请选择要操作的数据!',that);
                return ;
            }else if (this.selectedIds.length >1){
                dialog.warning('每次只能操作一条数据!',that);
                return ;
            }
        </#if>
        let confirmMsg = '确认要${operation.operationName}该${table.tableComment}？';
        let dialogFlag = dialog.confirm(confirmMsg);

        if (dialogFlag) {
            ${table.javaName}Api.${operation.operationResource}({ids: this.selectedIds.join(',')}, {
            onSuccess(res){
                dialog.success("${operation.operationName}${table.tableComment}成功",that);
                that.findList();
            }
            })
        }
    },
    </#if>
</#list>

          findList (){
                let that = this;
                ${table.javaName}Api.list(this.param, {
                    onSuccess(res) {
                        that.loading = false;
                        that.total = res.total;
                        that.data = res.rows;
                    }
                    });
            }

        },

        mounted () {
            let that = this;
            this.findList();


        <#if queryDictSet?exists && (queryDictSet?size > 0) >
        commonApi.allDicts('<#list queryDictSet as queryColumn><#if queryColumn.columnPage.exColumn?exists>${queryColumn.columnPage.exColumn.dictType}<#if queryColumn_has_next>,</#if><#else>${queryColumn.columnPage.columnConfig.dictType}<#if queryColumn_has_next>,</#if></#if></#list>', {
            onSuccess(dictMap) {
            <#list queryDictSet as queryColumn>
                <#if queryColumn.columnPage.exColumn?exists>that.${queryColumn.columnPage.exColumn.dictType}Dict=dictMap.get("${queryColumn.columnPage.exColumn.dictType}")<#if queryColumn_has_next>;</#if>
                <#else>that.${queryColumn.columnPage.columnConfig.dictType}Dict=dictMap.[("${queryColumn.columnPage.columnConfig.dictType}")<#if queryColumn_has_next>];</#if>
                </#if>
            </#list>
            }
        });
        </#if>


        }
    };
</script>
