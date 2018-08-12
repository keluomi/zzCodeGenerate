package ${table.fullPackageName}.${templet.fileInnerPackage};

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.util.StringUtils;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fullbloom.core.enums.EnumYesNo;
import com.fullbloom.utils.data.DateKit;
import com.fullbloom.core.vo.Pager;
import com.fullbloom.core.vo.AjaxJson;
import com.fullbloom.utils.java.IdUtils;

import com.fullbloom.core.exceptions.DbException;

import com.fullbloom.rbac.domain.TrUserBasicinfo;
import ${project.projectPackage}.baseweb.controller.RestfulBaseController;
import ${table.fullPackageName}.interfaces.${table.javaName}Service;
import ${table.fullPackageName}.exceptions.${table.javaName}Exceptions;
import ${table.fullPackageName}.domain.${table.javaName};

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ${table.tableComment} 控制层
 *
 * @author ${project.projectAuthor}
 * @date ${.now}
 */
@RestController
@RequestMapping("${table.fullResourceName}")
public class ${table.javaName}Controller extends RestfulBaseController {

	@Autowired
	private ${table.javaName}Service ${table.javaName?uncap_first}Service;

	/**
	* 新增或者修改时，检验数据是否唯一
	* @param request
	* @param response
	*/
	@RequestMapping( value = "/checkUnique" ,method = RequestMethod.POST)
	public Object checkUnique(HttpServletRequest request  , HttpServletResponse response )  {
		${table.javaName} ${table.javaName?uncap_first} = getObject(request , ${table.javaName}.class);
		${table.javaName} temp = ${table.javaName?uncap_first}Service.findTopOne4Check(${table.javaName?uncap_first});
		if(isEntityExist(temp)) {
			return new AjaxJson(false,"数据重复！");
		}else{
			return AjaxJson.successAjax;
		}
	}



	@RequestMapping( value = "/checkAllUnique" ,method = RequestMethod.POST)
	public Object checkAllUnique(HttpServletRequest request  , HttpServletResponse response )  {
		${table.javaName} ${table.javaName?uncap_first} = getObject(request , ${table.javaName}.class);
		boolean isExist =  this.isExist(${table.javaName?uncap_first});
		if(isExist) {
			return new AjaxJson(false,"数据重复！");
		}else{
			return AjaxJson.successAjax;
		}
	}



	private boolean isExist(${table.javaName} ${table.javaName?uncap_first})  {

		${table.javaName}  ckEntity = null;
		boolean isExist = false;


		${table.javaName}  temp = null;

		<#list indexs as begin>
		ckEntity = new ${table.javaName} ();
		<#list begin.javaNames as javaName>
		ckEntity.set${javaName?cap_first}( ${table.javaName?uncap_first}.get${javaName?cap_first}() );
		</#list>
        ckEntity.setId( ${table.javaName?uncap_first}.getId() );
        temp = ${table.javaName?uncap_first}Service.findTopOne4Check(ckEntity);
        if(isEntityExist(temp)) {
			return true;
		}
		</#list>


		return isExist;
	}




	/**
	 * 保存${table.tableComment}
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/save",method = RequestMethod.POST)
	public Object save(HttpServletRequest request, HttpServletResponse response ) {
		${table.javaName} ${table.javaName?uncap_first} = getObject(request , ${table.javaName}.class);

		if(isExist(${table.javaName?uncap_first}) ) {
			throw DbException.DB_SAVE_SAME;
		}

		TrUserBasicinfo loginUser = this.getSessionVO().getTrUserBasicinfo();

		AjaxJson ajaxJson = null;
		String id = ${table.javaName?uncap_first}.getId();
		if(StringUtils.isEmpty(id)){
			//保存数据
			autoSetInsertEntity(${table.javaName?uncap_first},loginUser);

			int size = ${table.javaName?uncap_first}Service.save(${table.javaName?uncap_first});
 			ajaxJson = new AjaxJson(true,"${table.tableComment}保存成功！");
			if (size<=0){
				throw ${table.javaName}Exceptions.Save_Error;
			}
		}else{
			//修改数据

			${table.javaName} temp = ${table.javaName?uncap_first}Service.findById(id);
			${table.javaName?uncap_first}.setVersionNo(temp.getVersionNo());

			autoSetUpdateEntity(${table.javaName?uncap_first},loginUser);

			int size = ${table.javaName?uncap_first}Service.update(${table.javaName?uncap_first});
			ajaxJson = new AjaxJson(true,"${table.tableComment}修改成功！");
			if (size<=0){
				throw ${table.javaName}Exceptions.Update_Error;
			}
		}
		return ajaxJson;
	}

	/**
	* 查询分页数据
	* @param request
	* @param response
	* @return
	*/
	@RequestMapping(value = "/list" ,method = RequestMethod.GET)
	public Object list( HttpServletRequest request, HttpServletResponse response){

		${table.javaName} ${table.javaName?uncap_first} = getObject(request , ${table.javaName}.class);

		Pager pager = new Pager();
		processPager(pager , ${table.javaName?uncap_first} , request);
		pager = ${table.javaName?uncap_first}Service.findPageList(${table.javaName?uncap_first},pager);
		return pager2Map(pager);
	}


	/**
	* 明细信息
	* @param id
	* @param request
	* @param response
	* @return
	*/
	@RequestMapping(value = "/detail/{id}" ,method = RequestMethod.GET)
	public Object detail(@PathVariable("id") String id , HttpServletRequest request, HttpServletResponse response){
		Map map = new HashMap<String,Object>();
		${table.javaName} ${table.javaName?uncap_first} = ${table.javaName?uncap_first}Service.findById(id);
		map.put("${table.javaName?uncap_first}" , ${table.javaName?uncap_first});
		return map;

	}



	/**
	* 删除${table.tableComment}
	*
	* @param request
	* @param response
	*/
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Object delete( HttpServletRequest request, HttpServletResponse response) {

		String ids = getParamString(request,"ids");

		if(ids == null || ids.isEmpty()){
			new AjaxJson(false,"请先选择要删除的记录！");
		}

		String []idString = ids.split(",");
		if(idString == null || idString.length == 0 ){
			new AjaxJson(false,"请先选择要删除的记录！");
		}

		List list = Arrays.asList(idString);

		${table.javaName} ${table.javaName?uncap_first} = new ${table.javaName}();
		${table.javaName?uncap_first}.setQueryIdList(list);

		List<${table.javaName}> ${table.javaName?uncap_first}s = ${table.javaName?uncap_first}Service.findList(${table.javaName?uncap_first});

		if(${table.javaName?uncap_first}s == null || ${table.javaName?uncap_first}s.isEmpty()){
			new AjaxJson(false,"该记录您无权删除！");
		}

		AjaxJson ajaxJson = new AjaxJson(true,"投资者删除成功！");
		int size = ${table.javaName?uncap_first}Service.delete(${table.javaName?uncap_first}s);
		if(size != ${table.javaName?uncap_first}s.size()){
			throw ${table.javaName}Exceptions.Delete_Error;
		}
		return ajaxJson;



	}


}