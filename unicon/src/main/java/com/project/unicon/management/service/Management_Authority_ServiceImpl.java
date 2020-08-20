package com.project.unicon.management.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.unicon.mappers.Member_Mapper;
import com.project.unicon.vo.Member_VO;

@Service("management_Authority_Service")
@Transactional(propagation = Propagation.REQUIRED)
public class Management_Authority_ServiceImpl implements Management_Authority_Service{
	
	@Autowired
	private Member_Mapper member_Mapper;
	
	@Override
	public int manager_Id_Check(String id) throws Exception{
		return member_Mapper.manager_Id_Check(id);
	}
	
	@Override
	public int manager_Phone_Check(String phone_Number) throws Exception{
		return member_Mapper.manager_Phone_Check(phone_Number);
	}
	
	@Override
	public void add_Authority(Member_VO member) throws Exception{
		member.setNickname("관리자"+member_Mapper.manager_Seq_Num());
		member_Mapper.insertManagerMember(member);
		Member_VO recomMember = new Member_VO();
		String id = member.getId();
		recomMember.setId(id);
		
		member_Mapper.recommendinsert(recomMember);
	}
	
	@Override
	public int confirm_Password(Map<String, String> values) throws Exception{
		return member_Mapper.confirm_Password(values);
	}
	
	@Override
	public List<Member_VO> selectAuthorList() throws Exception{
		return member_Mapper.selectAuthorList();
	}
	
	@Override
	public void deleteAuthor(String id) throws Exception{
		member_Mapper.deleteAuthor(id);
	}
	
	@Override
	public void updateAuthorPw(String id, String pw) throws Exception{
		member_Mapper.updateAuthorPw(id, pw);
	}
	
	/*0801추가*/
	@Override
	public void modifyAuthor(String id, int grade) throws Exception{
		member_Mapper.modifyAuthor(id, grade);
	}

}
