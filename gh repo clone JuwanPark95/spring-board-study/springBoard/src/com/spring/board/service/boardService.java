package com.spring.board.service;

import java.util.HashMap;
import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public BoardVo boardUpdate(BoardVo boardVo);

	public int boardUpdateAction(BoardVo boardVo);

	public int boardDelete(BoardVo boardVo);

	public List<BoardVo> boardSelectList(HashMap<String, Object> hMap);

	public int selectBoardSelectCnt(String string);

	public List<BoardVo> SelectAllBoardType();


}
