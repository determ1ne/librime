setlocal

if not defined RIME_ROOT set RIME_ROOT=%CD%

if not defined boost_version set boost_version=1.79.0
set boost_x_y_z=%boost_version:.=_%

if not defined BOOST_ROOT set BOOST_ROOT=%RIME_ROOT%\deps\boost_%boost_x_y_z%

if exist "%BOOST_ROOT%\boost" goto boost_found
for %%I in ("%BOOST_ROOT%\.") do set src_dir=%%~dpI
rem download boost source
powershell "iwr https://boostorg.jfrog.io/artifactory/main/release/%boost_version%/source/boost_%boost_x_y_z%.7z -OutFile %src_dir%boost_%boost_x_y_z%.7z"
pushd %src_dir%
7z x boost_%boost_x_y_z%.7z
popd
:boost_found

call .\build.bat boost_all
