$LIMITTIME=2.1;
$TIMEOUT=30;

javac --version | Out-Null
if ( -not $? ) {
    Write-Host "javac not found.";
    Write-Host "Abort.";
    exit 1;
}
java --version | Out-Null
if ( -not $? ) {
    Write-Host "java not found.";
    Write-Host "Abort.";
    exit 1;
}




New-Item ".\tmp" -ItemType Directory | Out-Null
Copy-Item .\Main.java .\tmp\Main.java;
Push-Location ".\tmp";

javac Main.java;

$data=(Get-Content (Join-path "../../datas" "data_104.dat"));
$ans=(Get-Content (Join-path "../../answers" "ans_104.dat"));

$job1 = Start-Job -ScriptBlock {
    Param($rootpath, $data);
    Push-Location $rootpath;
    $tmp=''
    $time=Measure-Command {
        $tmp=($data  | java Main);
    }
    return "$($time.TotalSeconds)`t$($tmp)";
} -ArgumentList (Location).path, $data

Wait-Job $job1 -TimeOut $TIMEOUT | Out-Null

Write-Host "DATA1: --------";
if ( $job1.State -eq "Completed" ) {
    $ret=(Receive-Job $job1);
    $time, $tmp = $ret -split "`t";
    $tmp = $tmp -replace " +`r?`n?`$", "";
    $res=(Compare-Object -ReferenceObject $ans -DifferenceObject $tmp);

    # 制限時間内に完答した
    if ( $res -eq $null -and [double]::parse($time) -le $LIMITTIME ) {
        Write-Host "Ellapsed Time(seconds): $($time)";
        Write-Host "AC";
    } elseif ( [double]::parse($time) -gt $LIMITTIME ) {
        Write-Host "TLE";
    } else {
        Write-Host "WA";
    }

} elseif ( $job1.State -eq "Running" ) {
     Write-Host "TLE";
} elseif ( $job1.State -eq "Failed" ) {
     Write-Host "RE";
}
Remove-Job -force $job1;


Pop-Location
Remove-Item -Force -Recurse .\tmp

# EOF