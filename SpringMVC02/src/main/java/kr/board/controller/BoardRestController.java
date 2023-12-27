package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board")
@RestController //@ResponseBody(JSON)응답
public class BoardRestController {
	@Autowired
	BoardMapper boardMapper;
	
	//@ResponseBody -> jackson-databind(객체를 ->JSON 데이터 포맷으로 변환)
	//@RequestMapping("/boardList.do")
	@GetMapping("/all")
	public List<Board> boardList() {
		List<Board> list = boardMapper.getLists();
		return list; //JSON 데이터 형식으로 변환(api)해서 리턴(응답)하겠다
	}
	
	//@RequestMapping("/boardInsert.do")
	@PostMapping("/new")
	public void boardInsert(Board vo) {
		boardMapper.boardInsert(vo); //등록 성공
	}
	
	//@RequestMapping("/boardDelete.do")
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {
		boardMapper.boardDelete(idx);
	}
	
	//@RequestMapping("/boardUpdate.do")
	@PutMapping("/update") //json형식으로 받아야할 때 @RequestBody 붙인다
	public void boardUpdate(@RequestBody Board vo) {  
		boardMapper.boardUpdate(vo);
	}
	
	//@RequestMapping("/boardContent.do")
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo; //vo ->JSON
	}
	
	//@RequestMapping("/boardCount.do")
	@PutMapping("/count/{idx}")
	public Board boardCount(@PathVariable("idx") int idx) {
		boardMapper.boardCount(idx); //조회수 늘려주고
		Board vo = boardMapper.boardContent(idx); //게시물정보를 담고
		return vo; //리턴함
	}

}
