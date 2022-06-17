package com.klk.bank.dummy;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@PostMapping(path = "edit", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(ReplyDto reply, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			String user_id = principal.getName();
			reply.setUser_id(user_id);
			
			boolean success = replyService.insertReply(reply);
			
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
			
		}
		
	}
	
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("id") int id, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			
			boolean success = replyService.deleteReply(id, null);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}		
	}
	
	@GetMapping("search")
	public List<ReplyDto> replyList(int productId, Principal principal) {
		if (principal == null) {
			return replyService.getReplyByProductId(productId);
		} else {
			return replyService.getReplyWithOwnByProductId(productId, principal.getName());
		}
	}
}
