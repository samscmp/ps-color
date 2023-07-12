Color
=======

A fork of brunovieira97 ps-color that was fored from Davlind's PSColor Module, providing color highlighting for PowerShell Cmdlets in a native and interoperable way.

Color highlighting is achieved by overriding Out-Default, and intercepting specific output types. Currently supported outputs:

* FileInfo & DirectoryInfo objects (Get-ChildItem and its aliases)
* ServiceController objects (Get-Service)
* MatchInfo objects (Select-String)
* Some Error coloring

If you'd like a new type of data supported, please feel free to create an Issue or contribute with a PR!

## Disclaimer

This work is still heavily based on brunovieira97 and Davlind's original PSColor, and the LICENSE contains his name explicitly.

## Why fork PSColor?

Mainly I wanted to add a lot more file types, I then refactered some of the file printing code so it is easer to maintain the config file. and one bug fix. hopefully i will get some of this merged back with brunovieira97's fork.

## Installation

This would have to be done manually right now.

## Configuration

You can configure Color by overriding the values of colors, patterns etc. Configurations should be added after `Import-Module Color` in your PowerShell profile. The [default configuration](src/config/Default.ps1) looks like:

```powershell
$global:ColorSettings = @{
    File = @{
        DefaultColor = "Gray";
	Types = @{
            Code = @{
	        Color   = "Magenta";
	        Pattern = "\.(java|c|cpp|cs|js|css|html)$";
            }
	}
    }
    Service = @{
        DefaultColor = "White";
        Status = @{
            Running = @{
                Color = "DarkGreen";
            }
            Stopped = @{
                Color = "DarkRed";
            }
        }
    }
    Match = @{
        DefaultColor = "Gray";
        Path         = @{
            Color = "Cyan";
        }
    }
    NoMatch = @{
        DefaultColor = "Gray";
        Path         = @{
            Color = "Cyan";
        }
    }
}
```

### Colors

Colors can be set based on their names as well as their hexadecimal codes*. When using names, you're limited to the standard 16 colors as observed on Conhost Properties window. When setting the hexadecimal code, use a string and don't forget the `#`!

#### Support for hexadecimal colors is implemented on version 2.1+, and it requires PowerShell 6+.

So, let's say you want to use Blue for source code files instead of the default one (Magenta). All you have to do is add this to your PowerShell Profile:

```powershell
# Using the color name
$Global:ColorSettings.File.Types.Code.Color = "Blue";

# Using the hexadecimal code
$Global:ColorSettings.File.Types.Code.Color = "#3b79ff";
```
