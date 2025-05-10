require 'application_system_test_case'

class QuestionsTest < ApplicationSystemTestCase
  setup do
    @question = questions(:one)
  end

  test 'visiting the index' do
    visit questions_url
    assert_selector 'h1', text: 'Questions'
  end

  test 'should create question' do
    visit questions_url
    click_on 'New question'

    fill_in 'Business dimension', with: @question.business_dimension_id
    fill_in 'Dimension', with: @question.dimension_id
    fill_in 'Content', with: @question.content
    fill_in 'Focus area', with: @question.focus_area_id
    fill_in 'Name', with: @question.name
    fill_in 'Questionnaire type', with: @question.questionnaire_type_id
    click_on 'Create Question'

    assert_text 'Question was successfully created'
    click_on 'Back'
  end

  test 'should update Question' do
    visit question_url(@question)
    click_on 'Edit this question', match: :first

    fill_in 'Business dimension', with: @question.business_dimension_id
    fill_in 'Dimension', with: @question.dimension_id
    fill_in 'Content', with: @question.content
    fill_in 'Focus area', with: @question.focus_area_id
    fill_in 'Name', with: @question.name
    fill_in 'Questionnaire type', with: @question.questionnaire_type_id
    click_on 'Update Question'

    assert_text 'Question was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Question' do
    visit question_url(@question)
    click_on 'Destroy this question', match: :first

    assert_text 'Question was successfully destroyed'
  end
end
