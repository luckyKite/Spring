package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	//@ResponseBody -> jackson-databind(객체를 ->JSON 데이터 포맷으로 변환)
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList() {
		List<Board> list = boardMapper.getLists();
		return list; //JSON 데이터 형식으로 변환(api)해서 리턴(응답)하겠다
	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void boardInsert(Board vo) {
		boardMapper.boardInsert(vo); //등록 성공
	}
	
	@RequestMapping("/boardDelete.do")
	public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {
		boardMapper.boardDelete(idx);
	}
	
	@RequestMapping("/boardUpdate.do")
	public @ResponseBody void boardUpdate(Board vo) {
		boardMapper.boardUpdate(vo);
	}
	
	@RequestMapping("/boardContent.do")
	public @ResponseBody Board boardContent(int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo; //vo ->JSON
	}
	
	@RequestMapping("/boardCount.do")
	public @ResponseBody Board boardCount(int idx) {
		boardMapper.boardCount(idx); //조회수 늘려주고
		Board vo = boardMapper.boardContent(idx); //게시물정보를 담고
		return vo; //리턴함
	}

}
