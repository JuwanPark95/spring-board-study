package com.spring.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<BoardVo> boardTypeList = new ArrayList<BoardVo>();
		
		int page = 1;
		/*현제 페이지 값이 없을경우 1로 정의*/
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}

		boardList = boardService.SelectBoardList(pageVo);
		boardTypeList = boardService.SelectAllBoardType();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageNo", page);
		model.addAttribute("boardTypeList",boardTypeList);
		
		return "/board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		List<BoardVo> boardTypeList = new ArrayList<BoardVo>();
		
		boardTypeList = boardService.SelectAllBoardType();
		
		model.addAttribute("boardTypeList",boardTypeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	/*게시글 수정*/
	@RequestMapping(value = "/board/boardUpdate.do", method = RequestMethod.POST)
	public ModelAndView boardUpdate(Locale locale, BoardVo boardVo, Model model) throws Exception{
		ModelAndView mv = new ModelAndView();

		boardVo = boardService.boardUpdate(boardVo);

		mv.addObject("board",boardVo);
		mv.setViewName("/board/boardUpdate");

		return mv;
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale, BoardVo boardVo) throws Exception{

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdateAction(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	/*게시글삭제*/
	@RequestMapping(value = "/board/boardDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(Locale locale, BoardVo boardVo) throws Exception{
				
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardDelete(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	/*게시물 조회*/
	@RequestMapping(value = "/board/boardSeachList.do", method = RequestMethod.POST)
	public ModelAndView boardSelectList(Locale locale, BoardVo boardVo, PageVo pageVo) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int page = 1;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		String pageNo = Integer.toString(pageVo.getPageNo());
		
		List<BoardVo> boardTypeList = new ArrayList<BoardVo>();
		boardTypeList = boardService.SelectAllBoardType();
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		String[] sArr = boardVo.getBoardType().split(",");
		
		HashMap<String, Object> hMap = new HashMap<>();
		
		hMap.put("sArr", sArr);
		hMap.put("pageNo",pageNo);
		
		
		boardList = boardService.boardSelectList(hMap);

		
		mv.addObject("boardList", boardList);
		mv.addObject("pageNo", page);
		mv.addObject("boardTypeList", boardTypeList);
		
		mv.setViewName("/board/boardList");
				
		return mv;
	}
	
	
}
