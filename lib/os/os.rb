require 'pathname'

module OS
    def walk(dir)
        root = Pathname dir
        files, dirs = [], []

        Pathname(root).find do |path|
            unless path == root
                dirs << path if path.directory?
                files << path if path.files?
            end
        end
        [root, dirs, files]
    end

    def func_file_walk(dir)
        root = Pathname(dir)
        
        Pathname(root).find do |path|
            begin
                unless  path == root
                    yield path if path.files?
                end
            rescue => exception
                next                
            end
        end
    end

    def func_dir_walk(dir)
        root = Pathname(dir)

        Pathname(root).find do |path|
            begin
                unless path == root
                    yield path if path.directory?
                end
            rescue => exception
                next                    
            end
        end
    end

    def func_walk(dir)
        root = Pathname(dir)
        file = nil
        dir = nil
    
        Pathname(root).find do |path|   
            begin
                unless path == root
                    dir = path if path.directory?
                    file = path if path.files?
                    yield(file,dir) if (dir != nil) && (file!=nil)
                end
            rescue => exception
                next
            end
        end
    end

end