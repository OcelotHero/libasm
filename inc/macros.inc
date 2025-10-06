%ifdef APPLE
%define ERRSYM          ___error
%define PLT_SUFFIX
%define WRITE           0x2000004
%define READ            0x2000003
%define FCT_NAME(name)  _name
%else
%define ERRSYM          __errno_location
%define PLT_SUFFIX      wrt ..plt
%define WRITE           1
%define READ            0
%define FCT_NAME(name)  name
%endif