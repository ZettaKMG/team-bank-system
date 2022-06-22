package com.klk.bank.mapper;

import java.util.List;

import com.klk.bank.domain.QnaDto;

public interface QnaMapper {

	void insertQnaBoard(QnaDto qna);

	List<QnaDto> selectQnaBoardAll();

}
