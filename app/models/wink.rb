class Wink < ApplicationRecord
  belongs_to :wink_sender, class_name: "User"
  belongs_to :wink_recipient, class_name: "User"
  validates :wink_sender_id, presence: true
  validates :wink_recipient_id, presence: true
  validate :one_wink_a_day, on: :create

  # validates_uniqueness_of :wink_sender_id, scope: [:wink_recipient_id, -> { where(created_at: past_24_hours) } ]



  private

def one_wink_a_day
  existing = Wink.where(wink_sender_id: self.wink_sender_id)
                .where(wink_recipient_id: self.wink_recipient_id)
                .where(created_at: Time.current.all_day)
  errors.add(:wink_recipient_id, 'Can only send one wink per day per person.') if existing
end


  # def user_not_blocked
  #   @user = User.find(params[:id])
  #   if @user.blocking?(current_user)
  #   # unless not_blocked?
  #     flash[:danger] = "You have been blocked by #{@user.full_name}"
  #     redirect_to users_path
  #   end
  # end

end
