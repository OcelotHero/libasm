%ifdef APPLE
%define ERRSYM      ___error
%define PLT_SUFFIX
%define MALLOC      _malloc
%define FREE        _free
%define WRITE       0x2000004
%define READ        0x2000003
%else
%define ERRSYM      __errno_location
%define PLT_SUFFIX  wrt ..plt
%define MALLOC      malloc
%define FREE        free
%define WRITE       1
%define READ        0
%endif