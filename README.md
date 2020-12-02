# giraffa-gke-zsh-theme

基于 http://raw.github.com/zakaziko99/agnosterzak-ohmyzsh-theme/master/agnosterzak.zsh-theme 修改

shell命令运行时间复制 https://github.com/caiogondim/bullet-train.zsh

增加 gcloud k8s 命令运行时间 的提示

调整配色和提示信息顺序

由于gcloud 和 kubectl 命令较慢，推荐在操作gcloud和k8s的时候使用此主题

**安装**

`curl -L -o $ZSH_CUSTOM/themes/giraffa-gke.zsh-theme https://github.com/yaule/giraffa-gke-zsh-theme/raw/main/giraffa-gke.zsh-theme`

**使用主题**

修改 ~/.zshrc 中 ZSH_THEME 的值

`ZSH_THEME="giraffa-gke"`

# 推荐使用方法


可以在 .zshrc中添加 theme 插件，使用 theme 命令随时切换主题

`plugins=( .... theme)`

**切换主题**

`theme giraffa-gke`
