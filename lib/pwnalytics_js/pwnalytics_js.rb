# Integration point with the Pwnalytics JS code.
module PwnalyticsJS

# Integration point with the Pwnalytics JS code.
module PwnalyticsJS
  # The bytes in the response to the GIF request.
  #
  # The response is a really tiny GIF.
  def self.gif_contents
    @gif_contents ||= gif_contents!
  end
  
  # The contents of the main Pwnalytics JS file.
  #
  # Args:
  #   request_url:: fully qualified URL to the backend that logs analytics data
  def self.main_js(request_url)
    @main_js ||= main_js! request_url
  end
  
  # The contents of the insertion JS file.
  #
  # Args:
  #   main_js_url:: fully qualified URL to the main Pwnalytics JS file
  #   property_id:: the pid value in the Pwnalytics session
  def self.insertion_js(main_js_url, property_id)
    raw_insertion_js(main_js_url).sub('AA123456', property_id).
        sub('bin/p.min.js', main_js_url)
  end
  
  # The bytes in the response to the GIF request.
  #
  # This reads the file from the disk every time.
  def self.gif_contents!
    File.open(File.expand_path('../p.gif', __FILE__), 'rb') { |f| f.read }
  end

  # The contents of the main Pwnalytics JS file.
  #
  # Args:
  #   request_url:: fully qualified URL to the backend that logs analytics data
  #
  # This reads the file from the disk every time.
  def self.main_js!(request_url)
    raw = File.open(File.expand_path('../p.min.js', __FILE__), 'rb') do |f|
      f.read
    end
    raw.sub 'bin/p.gif', request_url
  end
  
  # The contents of the insertion JS file, with a generic property ID.
  #
  # Args:
  #   main_js_url:: fully qualified URL to the main Pwnalytics JS file
  def self.raw_insertion_js(main_js_url)
    @raw_insertion_js ||= raw_insertion_js! main_js_url
  end

  # The contents of the insertion JS file, with a generic property ID.
  #
  # Args:
  #   main_js_url:: fully qualified URL to the main Pwnalytics JS file
  #
  # This reads the file from the disk every time.
  def self.raw_insertion_js!(main_js_url)
    raw_path = File.expand_path('../insert.min.js', __FILE__)
    raw = File.open(raw_path, 'rb') { |f| f.read }
    raw.sub 'bin/p.gif', main_js_url
  end
end  # module PwnalyticsJS::PwnalyticsJS

end  # namespace PwnalyticsJS
