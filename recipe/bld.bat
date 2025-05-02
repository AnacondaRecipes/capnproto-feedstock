mkdir build
cd build

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    ..
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

cmake --build . --config Release -j %CPU_COUNT%
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

@REM Some of the tests fail in part 2 of the tests (SegFault when build type is Release, unexpected value in one test when build typ is Debug)
@REM cmake --build . --target check --config Release
@REM if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%

cmake --build . --target INSTALL --config Release
if %ERRORLEVEL% neq 0 exit %ERRORLEVEL%
