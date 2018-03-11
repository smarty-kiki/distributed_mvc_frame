# distributed_mvc_frame
由 [frame](https://github.com/smarty-kiki/frame#frame) 框架衍生的分布式框架中的应用层 MVC 框架, 供快速开发使用

## 目录结构及文件说明

├── config (配置文件目录)  
│   ├── development (开发环境配置覆盖目录)                               
│   ├── production (线上愿景配置覆盖目录)  
├── controller (控制器文件目录)  
│   └── index.php (helloworld 控制器)  
├── frame (frame 框架目录，[点此查看明细说明](https://github.com/smarty-kiki/frame#目录结果及文件说明))   
├── interceptor (拦截器目录)  
├── project (项目相关文件目录)  
│   ├── config (配置文件目录)  
│   │   ├── development (开发环境)  
│   │   │   ├── nginx (nginx 配置)  
│   │   │   │   └── distributed_mvc_frame.conf (框架推荐的 nginx 配置)  
│   │   └── production (线上环境)   
│   │       ├── nginx  
│   │       │   └── distributed_mvc_frame.conf  
│   └── tool (工具脚本目录)  
│       ├── classmap.sh (生成 ORM load 文件)  
│       ├── dep_build.sh (加载依赖 service、client 的脚本)  
│       ├── naming_project.sh (快速修改本项目中的 nginx、supervisor 等配置中与项目目录有关的项目名称方便创建新项目使用)  
│       └── start_dev_server.sh (快速启动开发环境的脚本，基于 docker)  
├── public (入口文件目录)  
│   └── index.php (web 请求入口文件)  
├── util (工具类文件目录)  
│   └── load.php (工具类加载文件)  
├── dep_service_list (在此文件中声明所依赖的 service 项目，由 dep_build.sh 加载进代码中)  
├── dep_client (该文件夹及内容由 dep_build.sh 基于 dep_service_list 加载依赖项目生成，存放依赖 service 的 client)  
│   └── load.php (dep_client 框架加载文件)  
├── dep_domain (该文件夹及内容由 dep_build.sh 基于 dep_service_list 加载依赖项目生成，存放依赖 service 的 domain 层逻辑，含 dao、entity、knowledge、exception 等)  
│   └── load.php (dep_domain 框架加载文件)  
├── dep_cli_list (在此文件中声明所依赖的 command line 项目，由 dep_build.sh 加载进代码中)  
├── dep_queue_job (该文件夹及内容由 dep_build.sh 基于 dep_cli_list 加载依赖项目生成，存放依赖 command line 项目的 queue job)  
│   └── load.php (dep_queue_job 框架加载文件)  
├── LICENSE  
├── README.md  
└── bootstrap.php (框架通用加载文件)  
  
## 10 秒看到 helloworld
  
1. 先将代码 clone 或者下载到本地
2. 确保机器上有 docker 环境
3. 执行代码中的脚本快速启动环境 sh project/tool/start_dev_server.sh  
4. 输入当前用户密码。此处是为了开发方便映射了 80 端口，若不允许使用 80 可以手动修改第三条提到的脚本更换端口

