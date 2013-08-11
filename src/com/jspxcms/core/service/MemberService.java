package com.jspxcms.core.service;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Sort;

import com.jspxcms.common.util.RowSide;
import com.jspxcms.core.domain.Member;

/**
 * MemberService
 * 
 * @author liufang
 * 
 */
public interface MemberService {
	public List<Member> findList(Map<String, String[]> params, Sort sort);

	public RowSide<Member> findSide(Map<String, String[]> params, Member bean,
			Integer position, Sort sort);

	public Member get(Integer id);

	public Member save(Member bean);

	public Member update(Member bean);

	public Member delete(Integer id);

	public Member[] delete(Integer[] ids);
}
