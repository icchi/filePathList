# -*- encoding: UTF-8 -*-
require 'find'

class FilePathListOption
  class << self
    # = 除外リスト
    # 正規表現で除外する一覧を指定
    def exclusionOption
      '(\.svn|bin|debug|release)'
    end

    # = 対象リスト
    # 正規表現でファイルに書き出す一覧を指定
    def targetOption
      '(.*\.cpp|.*\.h)'
    end
  end
end


# 引数チェック
if ARGV.size <= 0 || !FileTest::directory?(ARGV[0])
  puts 'Please specify a directory.'
  exit
end

# 正規表現クラスを作成
exclusionOption = Regexp.new(FilePathListOption.exclusionOption, Regexp::IGNORECASE)
targetOption = Regexp.new(FilePathListOption.targetOption)

# ファイル一覧の書き込み開始
Dir::chdir ARGV[0]
File.open("fileList.txt", "w") do |outputFile|
  Find.find(ARGV[0]) do |f|
    Find.prune if f =~ exclusionOption
    next unless File::extname(f) =~ targetOption
    outputFile.puts(f)
  end
end

