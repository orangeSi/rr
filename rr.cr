
def show(file,tag)
	all=""
	index=0
	File.each_line(file) do |line|
		arr= line.split(/\t/)
		#all+=arr[0]+"\t"+arr[1]
		if arr[0]=~ /#{tag}/i
			index+=1
			all+=index.to_s+"\t"+arr[0]+"\t "+arr[1..-1].join("\t")+"\n"
		end
	end
	if index == 0
		all="no search result\n"
	end
	return all
end


def list(file)
	puts "not support list yet"
	exit 0
end

def add(file, tag, path)
	content = ""
	path.each {|e| content += "#{e} "}
	myfile=File.open(file, "a")
	myfile.puts(tag+"\t[ "+content+" ]\t"+Time.new.to_s+"\n")
	myfile.close
	return "add done\n"
end

def check_db_exists(file)
	unless File.exists?(file)
		File.write(file, "")
	end
end

user=`readlink -f ~`.chomp
file=user+"/.rubydb"
usage="
    Usage1:add <bookmarks> <bookmarks content>\tadd bookmarks
    Usage2:<bookmarks>\t\t\t\tshow bookmarks content
    Usage3:rm <bookmarks.index> cannot be used not yet

    Author:sikaiwei@genomics.cn
"

if ARGV.size == 0 || ARGV.size == 2
	puts usage
	exit
elsif ARGV.size == 1
	check_db_exists(file)
	puts show(file, ARGV[0])
elsif ARGV.size >=3
	check_db_exists(file)
	if ARGV[0]=~ /^add$/i
		puts add(file, ARGV[1], ARGV[2..-1])
	elsif ARGV[0]=~ /^list$/i
		puts list(file)
	else
		puts usage
		exit
	end

end



