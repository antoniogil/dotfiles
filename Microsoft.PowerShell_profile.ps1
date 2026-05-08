set DOTNET_CLI_TELEMETRY_OPTOUT=1

function GotoCode {
  Set-Location c:/Code
}

Set-Alias ccode GotoCode;

oh-my-posh init pwsh --config "avit" | Invoke-Expression
