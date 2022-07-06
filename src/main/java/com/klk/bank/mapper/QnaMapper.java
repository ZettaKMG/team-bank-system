package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.QnaDto;

public interface QnaMapper {

	void insertQnaBoard(QnaDto qna);

	List<QnaDto> selectQnaBoardAll(@Param("from")int from, @Param("row_per_page")int row_per_page);

	QnaDto selectQnaBoardById(int id);

	void updateQnaBoard(QnaDto qna);

	void deleteQnaBoard(QnaDto qna);


	void deleteQnaBoardByUserId(String user_id);

	int selectCountAllQna();


}
