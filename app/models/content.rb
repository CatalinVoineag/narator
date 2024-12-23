class Content < ApplicationRecord
  validates :body, presence: true

  has_one :kernel_command
  has_one_attached :audio

  def run_kernel_command
    system(kernel_command)
  end

  def self.sanitize(content)
    # Change 18m to millions same for billions
    sanitised_content = content.gsub("%", " percent")
      .gsub("$", " dollars ")
      .gsub("€", " euros ")
      .gsub("£", " pounds ")
      .gsub("\n", "")
      .gsub("(", "")
      .gsub(")", "")
      .gsub("[", "")
      .gsub("]", "")
      .gsub("]", "")
      .gsub("“", "")
      .gsub("”", "")

    sanitised_content
  end
end
