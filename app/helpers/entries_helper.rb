module EntriesHelper
  def find_insights(entry, body, parent = nil)
    # p body
    if body.children.any?
      body.children.each do |child|
        find_insights(entry, child, body)
      end
    else
      # p body.to_s
      arel = Insight.arel_table
      query = arel[:context].matches("%#{body.to_s}%")
      insight = entry.insights.find_by(query)
      if insight
        if insight.context == body.to_s
          parent["data-controller"] = "tippy"
          parent["data-tippy-content-value"] = insight.insight
          parent["class"] = "rounded pl-2 border-green-500 mb-1 bg-green-100/75"
        else
          match = false
          root = parent
          loop do
            break if root.nil?
            p "comparing #{root.text} to #{insight.context}"
            if root.text == insight.context || root.text.end_with?(insight.context)
              root["data-controller"] = "tippy"
              root["data-tippy-content-value"] = insight.insight
              root["class"] = "rounded pl-2 border-green-500 mb-1 bg-green-100/75"
              break
            else
              root = root.parent
            end
          end

          return
        end
      end
    end
  end
end
