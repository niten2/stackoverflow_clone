shared_examples_for "Vote" do

  describe 'PATCH #upvote' do
    describe "other user" do
      before { sign_in(other_user) }
      it 'renders object/vote.json.jbuilder' do
        patch :upvote, id: object, format: :json
        expect(response).to render_template :vote
      end

      it 'save upvote' do
        expect { patch :upvote, id: object, format: :json }.to change(object.votes.upvotes, :count).by 1
      end

      it 'delete upvote' do
        expect { patch :upvote, id: object, format: :json }.to change(object.votes.upvotes, :count).by 1
        expect { patch :unvote, id: object, format: :json }.to change(object.votes.upvotes, :count).by -1
      end
    end

    describe "user tried"  do
      before { sign_in(user) }
      it 'renders object/vote.json.jbuilder' do
        patch :upvote, id: object, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save upvote' do
        expect { patch :upvote, id: object, format: :json }.to_not change(object.votes.upvotes, :count)
      end

      it 'delete upvote' do
        expect { patch :upvote, id: object, format: :json }.to_not change(object.votes.upvotes, :count)
        expect { patch :unvote, id: object, format: :json }.to_not change(object.votes.upvotes, :count)
      end
    end
  end

  describe 'PATCH #downvote' do
    describe 'other_user' do
      before { sign_in(other_user) }
      it 'renders object/vote.json.jbuilder' do
        patch :downvote, id: object, format: :json
        expect(response).to render_template :vote
      end

      it 'save downvote' do
        expect { patch :downvote, id: object, format: :json }.to change(object.votes.downvotes, :count).by 1
      end

      it 'delete downvote' do
        expect { patch :downvote, id: object, format: :json }.to change(object.votes.downvotes, :count).by 1
        expect { patch :unvote, id: object, format: :json }.to change(object.votes.downvotes, :count).by -1
      end

      it 'renders object/vote.json.jbuilder' do
        patch :unvote, id: object, format: :json
        expect(response).to render_template :vote
      end
    end

    describe 'user tried' do
      before { sign_in(user) }
      it 'renders object/vote.json.jbuilder' do
        patch :downvote, id: object, format: :json
        expect(response).to_not render_template :vote
      end

      it 'save downvote' do
        expect { patch :downvote, id: object, format: :json }.to_not change(object.votes.downvotes, :count)
      end

      it 'delete downvote' do
        expect { patch :downvote, id: object, format: :json }.to_not change(object.votes.downvotes, :count)
        expect { patch :unvote, id: object, format: :json }.to_not change(object.votes.downvotes, :count)
      end

      it 'renders object/vote.json.jbuilder' do
        patch :unvote, id: object, format: :json
        expect(response).to_not render_template :vote
      end
    end
  end

end
