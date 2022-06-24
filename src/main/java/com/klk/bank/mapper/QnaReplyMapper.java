package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.QnaReplyDto;

public interface QnaReplyMapper {

	void insertQnaReply(QnaReplyDto dto);

	List<QnaReplyDto> selectQnaReplyById(@Param("qna_id")int qna_id);

	List<QnaReplyDto> selectAllQnaReplyById(@Param("qna_id")int qna_id, @Param("user_id")String user_id);

}
