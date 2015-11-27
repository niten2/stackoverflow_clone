json.extract! @answer, :id
json.upvotes @answer.votes.upvotes.count
json.downvotes @answer.votes.downvotes.count
json.rating @answer.votes.rating
json.voted current_user.voted_for? @answer
json.upvote_url upvote_answer_path(@answer)
json.downvote_url downvote_answer_path(@answer)
json.unvote_url unvote_answer_path(@answer)