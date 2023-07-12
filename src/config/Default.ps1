# Default configuration

$Global:ColorSettings = @{
	General = @{
		ShortenUserFolder = $true;
	}
	File = @{
		DefaultColor = "#cccccc";
		Header = @{
			Visible = $true;
			TextColor = "#767676";
			SeparatorsColor = "#767676";
		}
		Path = @{
			Visible = $false;
			TitleColor = "#767676";
			TextColor = "#cccccc";
		}
		Types = @{
			Directory = @{
				Color = "#466bff";
			}
			SymbolicLink = @{
				Color = "#3b79ff";
				ShowTarget = $true;
			}
			Hidden = @{
				Color = "#767676";
				RegEx = "^\.";
			}
			Binary = @{
				Color = "#3a96dd";
				RegEx = "\.(exe|jar|msi|war|bin|iso|dmg|img|apk|deb|rpm|pak)$";
			}
			Code = @{
				Color = "#00d8bf";
				RegEx = "\.(ada|adb|ads|as|as3|asm|bas|bc|c|c\+\+|cbl|cc|class|clj|cljc|cljs|cob|coffee|cpp|cpy|cs|csh|csproj|ctl|cxx|d|diff|e|ejs|el|f|f77|f90|fla|for|frm|fth|ftn|go|groovy|h|hh|hpp|hs|hxx|java|jl|js|jsp|jsx|ksh|kt|lhs|lisp|lpr|lua|m|m4|nim|p|pas|patch|perl|ph|php|pl|plx|pm|po|pp|py|pyc|pyd|pyo|pyw|pyx|pyz|r|rb|rs|s|scala|sln|suo|swf|swg|swift|tcl|user|v|vala|vapi|vb|vbproj|vcproj|vcxproj|wsf|xcodeproj)$";
			}
			Data = @{
				Color = "#a0c001";
				RegEx = "\.(sql|json|db|xml|resx|csv|dat|css|html|htm|toml|yaml|yml|markdown|md)$";
			}
			Script = @{
				Color = "#2ac8f0";
				RegEx = "\.(bat|cmd|ps1|psm1|reg|sh|vbs|command|crx|bash|csh|fish|ksh|zsh)$";
			}
			Specific = @{
				Color = "#6ba529";
				RegEx = "\.(doc|docx|xls|xlsx|ppt|pptx|odt|ods|odp|rtf|pdf|ics|vcf|ebook|msg|org|pages|rst|tex|wpd|wps|mobi|epub|azw1|azw3|azw4|azw6|azw|cbr|cbz|3dm|3ds|max|ai|dwg|dxf|blend|eot|otf|ttf|woff|woff2)$";
			}
			Audio_video = @{
				Color = "#aa13b8";
				RegEx = "\.(bmp|dds|gif|jpg|jpeg|png|psd|xcf|tga|thm|tif|tiff|yuv|eps|ps|svg|gpx|kml|kmz|webp|aac|aiff|ape|au|flac|gsm|it|m3u|m4a|mid|mod|mp3|mpa|pls|ra|s3m|sid|wav|wma|xm|3g2|3gp|aaf|asf|avchd|avi|drc|flv|m2v|m4p|m4v|mkv|mng|mov|mp2|mp4|mpe|mpeg|mpg|mpv|mxf|nsv|ogg|ogv|ogm|qt|rm|rmvb|roq|srt|svi|vob|webm|wmv|yuv)$";
			}
			Compressed = @{
				Color = "#61d6d6";
				RegEx = "\.(zip|rar|7z|tar|gz|gzip|bz2|bzip2|xz|lzma|z|Z|ar|cab|lz|sz|a|cpio|egg|lha|mar|pea|s7z|shar|tbz2|tgz|tlz|war|whl|xpi|zipx)$"; 
			}
			Text = @{
				Color = "#e74856";
				RegEx = "\.(cfg|conf|config|ini|log|txt)$";
			}
		}
	}
	Service = @{
		DefaultColor = "#cccccc";
		Header = @{
			Visible = $true;
			TextColor = "#767676";
			SeparatorsColor = "#767676";
		}
		Status = @{
			Running = @{
				Color = "#13a10e";
			}
			Stopped = @{
				Color = "#c50f1f";
			}
		}
	}
	MatchInfo = @{
		Match = @{
			DefaultColor = "#cccccc";
			Path = @{
				Color = "#13a10e";
			}
			LineNumber = @{
				Color = "#13a10e";
			}
			Line = @{
				Color = "#ff0c0c";
			}
		}
		NoMatch = @{
			DefaultColor = "#cccccc";
			Path = @{
				Color = "#61d6d6";
			}
			LineNumber = @{
				Color = "#767676";
			}
			Line = @{
				Color = "#cccccc";
			}
		}
	}
};
