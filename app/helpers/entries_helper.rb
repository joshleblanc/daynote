module EntriesHelper
  def add_tippy(element, insight)
    element["data-controller"] = "tippy"
    element["data-tippy-content-value"] = insight.insight
    element["data-action"] = "mouseenter->tippy#onMouseEnter mouseleave->tippy#onMouseLeave"
  end

  def find_insight(insight, root)
    # Convert root to text for comparison
    root_text = root.text
    context = insight.context

    # If the context is found within this element
    if root_text.gsub(/[^a-zA-Z]/, "").include?(context.gsub(/[^a-zA-Z]/, "").strip)
      # Add data attributes for tooltip
      add_tippy(root, insight)
      return true
    end

    # If this element has children, check them
    root.children.each do |child|
      return true if find_insight(insight, child)
    end

    false
  end

  def find_insights(entry, parts, parent = nil)
    return unless parts && entry.insights

    entry.insights.each do |insight|
      context = insight.context

      # Try to find consecutive parts that form the context
      parts.each_with_index do |part, index|
        # Get text from current part and next few parts
        combined_text = ""
        current_parts = []

        parts[index..].each do |p|
          combined_text += p.text
          current_parts << p

          # Clean up whitespace for comparison
          if combined_text.gsub(/[^a-zA-Z]/, "").strip.include?(context.gsub(/[^a-zA-Z]/, "").strip)
            # Found matching consecutive parts
            add_tippy(current_parts.last, insight)
            break
          end

          # Stop if we've collected more text than the context
          break if combined_text.length > context.length * 2
        end
      end
    end
  end
end
