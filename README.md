Async_Process
===
Async_Process is a library for processing files into folders. Currently library assumes we have a root folder and inside of it there are folders that contain files we want to process. i.e:

    [root_folder]
        |
        --[folder1]
            \ file1
            \ file2
            \ file3
            
        --[folder2]
        .
        .
        .
        --[folderN]

Installing
===
Async_Process is not available as a Rubygem yet. If you have a rails project you can insert the line below to your Gemfile and then run the `bundle` command.
    
    gem 'async_process', git: 'git://github.com/icleversoft/async_process', require: false

Using Async_Process
===
It's pretty easy to use AsyncProcess. Below you can find a code example:

Example:

    require 'async_process'
    
    scanner = AsyncProcess::FileScanner.new('/path/to/root_folder')
    queue = AsyncProcess::Queue.new( scanner )
    queue.process do |on|
        on.file_to_process do |file|
            #Enter here your code for processing each file
        end
    end
