class ChecklistPage < ElementPage
  include PageObject

  text_field(:task, name: 'New item')

  def add_checklist(title="", tasks=[])
    title_element.when_present.send_keys title
    tasks.each { |task| add_new_task task }
    add
  end

  def add_new_task(content)
    task_element.when_present.send_keys content
  end
end
