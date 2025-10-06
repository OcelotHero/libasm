%ifdef APPLE
%define ERRSYM          ___error
%define PLT_SUFFIX
%define WRITE           0x2000004
%define READ            0x2000003
%define MALLOC          _malloc
%define FREE            _free
%define FT_READ         _ft_read
%define FT_STRCMP       _ft_strcmp
%define FT_STRCPY       _ft_strcpy
%define FT_STRDUP       _ft_strdup
%define FT_STRLEN       _ft_strlen
%define FT_WRITE        _ft_write
%define FT_ATOI_BASE    _ft_atoi_base
%define FT_LST_PUSH_F   _ft_list_push_front
%define FT_LST_REM_IF   _ft_list_remove_if
%define FT_LST_SIZE     _ft_list_size
%define FT_LST_SORT     _ft_list_sort
%else
%define ERRSYM          __errno_location
%define PLT_SUFFIX      wrt ..plt
%define WRITE           1
%define READ            0
%define MALLOC          malloc
%define FREE            free
%define FT_READ         ft_read
%define FT_STRCMP       ft_strcmp
%define FT_STRCPY       ft_strcpy
%define FT_STRDUP       ft_strdup
%define FT_STRLEN       ft_strlen
%define FT_WRITE        ft_write
%define FT_ATOI_BASE    ft_atoi_base
%define FT_LST_PUSH_F   ft_list_push_front
%define FT_LST_REM_IF   ft_list_remove_if
%define FT_LST_SIZE     ft_list_size
%define FT_LST_SORT     ft_list_sort
%endif