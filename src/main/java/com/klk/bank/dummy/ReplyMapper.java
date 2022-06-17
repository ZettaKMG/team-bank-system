package com.klk.bank.dummy;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ReplyMapper {

	boolean insertReply(ReplyDto reply);

	List<ReplyDto> selectAllProductId(@Param("product_id") int product_id, @Param("user_id") String user_id);

	int updateReply(ReplyDto reply);
	
	int deleteReply(int id);

	void deleteByProductId(int id);

	ReplyDto selectReplyById(int id);
	
}
