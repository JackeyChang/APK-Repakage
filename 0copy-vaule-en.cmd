@echo off
rem --------------------------------------------------------
rem ���p�X�̏ڍ�
rem
rem  set dropfpath=%1             //�@�t�@�C���t���p�X�ic:\XXX\XXX\xxx.file�j
rem  set fname=%~n1%~x1      //�@�t�@�C�����iXXX.apk�j
rem  set sfname=%~n1�@�@�@�@�@//�@�t�@�C�����̂݁iXXX.apk��XXX�����j
rem  set rundir=%~d0%~p0�@�@ //�@bat�t�@�C����PATH
rem
rem --------------------------------------------------------


set dropfpath=%1
set fname=%~n1%~x1
set sname=%~n1
set rundir=%~d0%~p0

rem --------------------------------------------------------
rem - Drop�����t�@�C����tmp�t�H���_�ɃR�s�[
rem - Drop�����t�@�C����fname%.orig�Ƃ���output�փR�s�[
rem --------------------------------------------------------

cd %rundir%
mkdir tmp
mkdir output
xcopy %dropfpath% tmp\
echo F | xcopy /y %dropfpath% output\%fname%.orig

rem --------------------------------------------------------
rem - apktool�ŁADrop����tmp�z����apk�t�@�C����W�J
rem --------------------------------------------------------

cd tmp
call apktool d -s -f %fname%

rem --------------------------------------------------------
rem - values-en��values-ja�Ƃ��ăR�s�[
rem --------------------------------------------------------

xcopy /S /E %sfname%\res\values-en %sfname%\res\values-ja\

rem --------------------------------------------------------
rem - apktool �ŁArepakage
rem --------------------------------------------------------

call apktool b %sfname%

rem --------------------------------------------------------
rem - �쐬���ꂽresources.arsc�t�@�C����7za�i�����k�j�ŏ㏑��
rem --------------------------------------------------------

xcopy %sfname%\build\apk\resources.arsc .\
7za.exe u -tzip -mx=0 %fname% resources.arsc

rem --------------------------------------------------------
rem - ��������apk�t�@�C����ouput�f�B���N�g���ɃR�s�[
rem --------------------------------------------------------

cd %rundir% 
echo F | xcopy tmp\%fname% output\%fname%


rem --------------------------------------------------------
rem - tmp�f�B���N�g�����폜
rem --------------------------------------------------------

rmdir /s /q tmp
pause
