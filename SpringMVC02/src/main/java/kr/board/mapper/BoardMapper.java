package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.Board;

@Mapper //MyBatis API
public interface BoardMapper {
	public List<Board> getLists(); //전체리스트
	public void boardInsert(Board vo);
	public Board boardContent(int idx);
	public void boardDelete(int idx);
	public void boardUpdate(Board vo);
	
	@Update("update myboard set count=count+1 where idx=#{idx}") //여기 적었으면 .mapper에 쿼리를 또 쓰면 안된다
	public void boardCount(int idx); //조회수 증가
}
