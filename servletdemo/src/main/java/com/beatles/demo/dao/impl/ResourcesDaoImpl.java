package com.beatles.demo.dao.impl;

import java.util.List;

import com.beatles.demo.dao.IResourcesDao;
import com.beatles.demo.entity.Resources;
import com.beatles.demo.view.ResourcesDTO;

/**
 * @author zhang lj
 * @createTime 2018年1月19日 上午11:22:08
 */
public class ResourcesDaoImpl implements IResourcesDao {

	@Override
	public List<Resources> getResourcesViewList() {
		String sql="select * from sys_res order by seq";
		return _resultList1(util.query(sql));
	}
	
}
