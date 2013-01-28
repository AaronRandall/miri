class BaseAction
  def process(action_text)
    raise NotImplementedError
  end

  def keywords
    raise NotImplementedError
  end
end
