$LIMITTIME=2.1;
$TIMEOUT=30;

python --version | Out-Null
if ( -not $? ) {
    Write-Host "python not found.";
    Write-Host "Abort.";
    exit 1;
}

New-Item ".\tmp" -ItemType Directory | Out-Null
Copy-Item .\main.py .\tmp\main.py;
Push-Location ".\tmp";


$data=(Get-Content (Join-path "../../datas" "data_10.dat"));
$ans=(Get-Content (Join-path "../../answers" "ans_10.dat"));

$job1 = Start-Job -ScriptBlock {
    Param($rootpath, $data);
    Push-Location $rootpath;
    $tmp=''
    $time=Measure-Command {
        $tmp=($data  | python main.py);
    }
    return "$($time.TotalSeconds)`t$($tmp)";
} -ArgumentList (Location).path, $data

Wait-Job $job1 -TimeOut $TIMEOUT | Out-Null

Write-Host "DATA1: --------";
if ( $job1.State -eq "Completed" ) {
    $ret=(Receive-Job $job1);
    $time, $tmp = $ret -split "`t";
    $res=(Compare-Object -ReferenceObject $ans -DifferenceObject $tmp);

    # 制限時間内に完答した
    if ( $res -eq $null -and [double]::parse($time) -le $LIMITTIME ) {
        Write-Host "Ellapsed Time(seconds): $($time)";
        Write-Host "AC";
    } elseif ( [double]::($time) -gt $LIMITTIME ) {
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



$data=(Get-Content (Join-path "../../datas" "data_103.dat"));
$ans=(Get-Content (Join-path "../../answers" "ans_103.dat"));

$job1 = Start-Job -ScriptBlock {
    Param($rootpath, $data);
    Push-Location $rootpath;
    $tmp=''
    $time=Measure-Command {
        $tmp=($data  | python main.py);
    }
    return "$($time.TotalSeconds)`t$($tmp)";
} -ArgumentList (Location).path, $data

Wait-Job $job1 -TimeOut $TIMEOUT | Out-Null

Write-Host "DATA2: --------";
if ( $job1.State -eq "Completed" ) {
    $ret=(Receive-Job $job1);
    $time, $tmp = $ret -split "`t";
    $res=(Compare-Object -ReferenceObject $ans -DifferenceObject $tmp);

    # 制限時間内に完答した
    if ( $res -eq $null -and [double]::parse($time) -le $LIMITTIME ) {
        Write-Host "Ellapsed Time(seconds): $($time)";
        Write-Host "AC";
    } elseif ( [double]::($time) -gt $LIMITTIME ) {
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






# cat data_103.dat | java Main;
