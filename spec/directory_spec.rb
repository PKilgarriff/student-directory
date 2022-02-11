require "directory"
require "mastery_answer_code_quality"

describe 'print' do
  it 'returns "No students are currently enrolled" if passed empty array' do
    expect(print([])).to eq "No students are currently enrolled"
  end

  it "has acceptable code quality" do
    code_quality = MasteryAnswerCodeQuality.build(__FILE__)
    expect(code_quality.acceptable?).to(eq(true), code_quality.problems)
  end

  # def set_user_input_and_check_expected_output
  #   allow_any_instance_of(Object)
  #     .to receive(:gets).and_return(user_input)

  #   expect { load "questions/question_1.rb" }
  #     .to output(/#{expected_output}/).to_stdout
  # end
end
