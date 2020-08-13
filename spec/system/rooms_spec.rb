require 'rails_helper'

RSpec.describe "Roomsチャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    FactoryBot.create_list(:message,5,room_id: @room_user.room.id, user_id: @room_user.user.id)
      #create_listを用いることで、messageテーブルのレコードをまとめて生成できます。
      #メッセージが削除されているか確認するためにcreate_listを用いて、メッセージと紐付いた、ユーザーとチャットルームを中間テーブルに生成します。
    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを期待する
    expect{find_link("チャットを終了する", href: room_path(@room_user.room)).click}.to change { @room_user.room.message.count }.by(-5)
      #find_linkメソッドで「"チャットを終了する",href:room_path(@room_user.room)」を取得して、クリックします。「チャットを終了する」をクリックすると、チャットルームは削除されるので、同じタイミングでmessageモデルのカウントが5つ減っていることを確認します。
        # ルートページに遷移されることを期待する
    expect(current_path).to eq root_path
  end








end
