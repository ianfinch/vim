FROM guzo/base

RUN cd /tmp/                                                                           && \
    apk --no-cache update                                                              && \
    apk --no-cache add python                                                          && \
    apk --no-cache --virtual guzo-dependencies add alpine-sdk ncurses-dev python-dev   && \
    git clone https://github.com/vim/vim.git                                           && \
    cd vim                                                                             && \
    ./configure --prefix=/usr --enable-pythoninterp                                    && \
    make install                                                                       && \
    apk del alpine-sdk ncurses-dev python-dev guzo-dependencies                        && \
    rm -rf /tmp/vim

RUN mkdir -p /home/ian/.vim/bundle                                  && \
    cd /home/ian/.vim/bundle                                        && \
    git clone https://github.com/chrisbra/Colorizer.git             && \
    git clone https://github.com/flazz/vim-colorschemes.git         && \
    git clone https://github.com/groenewege/vim-less.git            && \
    git clone https://github.com/jeetsukumaran/vim-buffergator.git  && \
    git clone https://github.com/jelera/vim-javascript-syntax.git   && \
    git clone https://github.com/kien/rainbow_parentheses.vim.git   && \
    git clone https://github.com/SirVer/ultisnips.git               && \
    git clone https://github.com/tpope/vim-fugitive.git             && \
    git clone https://github.com/tpope/vim-pathogen.git             && \
    git clone https://github.com/tpope/vim-vinegar.git              && \
    git clone https://github.com/vim-airline/vim-airline.git        && \
    git clone https://github.com/vim-scripts/nginx.vim.git          && \
    git clone https://github.com/vim-syntastic/syntastic.git        && \
    git clone https://github.com/ajmwagar/vim-deus.git              && \
    mkdir -p /home/ian/.vim/autoload/airline/themes

COPY vimrc /home/ian/.vimrc
COPY guzo-airline-theme.vim /home/ian/.vim/autoload/airline/themes/guzo.vim
ADD UltiSnips /home/ian/.vim/UltiSnips
RUN chown -R ian /home/ian/.vimrc /home/ian/.vim

USER ian
CMD vim --version
