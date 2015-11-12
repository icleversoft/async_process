module AsyncProcess  
  class FileScanner

    def initialize( root = '.' )
      @root =  root 
    end

    def folders
      if block_given?
        folders_array.each{|folder| yield folder}
      else
        folders_array.map{|x| last_path_part(x)}
      end
    end

    def files_for_folder(folder, pattern = "*.*")
      if block_given?
        files_array(folder, pattern).each{|file| yield file}
      else
        files_array(folder, pattern).map{|x| last_path_part(x)}
      end
    end

    def files_count( pattern = "*.*" )
      total_files_array(pattern).length
    end

    private
    def files_array(folder, pattern)
      Dir[File.join("#{@root}", last_path_part(folder), pattern)] 
    end

    def total_files_array( pattern = "*.*" )
      Dir[File.join(@root, "**", pattern)]
    end

    def folders_array
      Dir["#{@root}/**"]
    end

    def last_path_part( path  )
      path[/([^\/])+$/]
    end

  end
end
