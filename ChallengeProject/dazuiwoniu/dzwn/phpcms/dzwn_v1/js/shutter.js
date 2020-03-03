/**
 * Coder: EzrealY
 * Time: 2017.07.31
 * Mail: 1005526074@qq.com
 * 效果原作者: https://oss.so/article/71
 */
 
;(function ($, window, document, undefined) {

  var Shutter = function (elem, options) {
    this.defaults = {
      shutterW: 675,
      shutterH: 300,
      isAutoPlay: false,
      playInterval: 5000,
      curDisplay: 0,
      fullPage: false
    };
    this.opts = $.extend({}, this.defaults, options);

    this.inital(elem);
  };

  Shutter.prototype = {
    play: function () {
      var self = this;

      if (this.opts.isAutoPlay) {
        clearInterval(this.playTime);

        this.playTime = setInterval(function () {
          self.$nextBtn.click();
        }, this.opts.playInterval);
      }
    },

    moveSwitch: function (randomNum, command, index) {
      switch (randomNum) {
        case 0:
          this.gridWhole(index, 0);
        break;
        case 1:
          this.gridWhole(index, 1);
        break;
        case 2:
          this.gridWhole(index, 2);
        break;
        case 3:
          this.gridWhole(index, 3);
        break;
        case 4:
          this.gridTop(index, 0);
        break;
        case 5:
          this.gridTop(index, 1);
        break;
        case 6:
          this.gridTop(index, 2);
        break;
        case 7:
          this.gridLeft(index, 0);
        break;
        case 8:
          this.gridLeft(index, 1);
        break;
        case 9:
          this.gridLeft(index, 2);
        break;
        case 10:
          this.gridOpacity(index);
        break;
        case 11:
          this.gridAccordion(index);
        break;
        case 12:
          this.gridLittle(index);
        break;
        case 13:
          this.gridSwitch(index);
        break;
        default:
          this.gridTop(index, 0);
        break;
      }
    },

    toggleMove: function (command, index) {
      if (!command) {
        if (this.curDisplay === index) {
          return;
        } else if (this.curDisplay === 0 && index === this.shutterItem_len - 1
                  || index < this.curDisplay) {
          command = 'prev';
        } else {
          command = 'next';
        }
      }

      if (!index) {
        if (command === 'prev') {
          index = this.curDisplay - 1;

          if (this.curDisplay === 0) {
            index = this.shutterItem_len - 1;
          }
        } else {
          index = this.curDisplay + 1;

          if (this.curDisplay === this.shutterItem_len - 1) {
            index = 0;
          }
        }
      }

      this.$shutterDesc.animate({bottom: -36});

      var random = function (min, max) {
        return Math.floor(Math.random() * (max + 1) - min);
      };

      this.moveSwitch(random(0, 13), command, index);

      this.shutterTitle = this.$shutterItem.eq(index).attr('data-shutter-title');
    },

    initalShutter: function () {
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $nearlyElem = this.$shutterItem.not($curElem);

      $curElem.css('zIndex', 20);
      $nearlyElem.each(function (i) {
        $(this).css('zIndex', ++ i);
      });

      this.$shutter.css({width: this.opts.shutterW, height: this.opts.shutterH});

      if (this.opts.fullPage) {
        this.$shutter.css({
          width: $(window).width(),
          height: $(window).height(),
          margin: 0,
          borderRadius: 0,
          border: 'none'
        });
      }
    },

    inital: function (elem) {
      var self = this;
      this.$shutter = elem;
      this.$shutterItem = this.$shutter.find('.shutter-img a');
      this.$prevBtn = this.$shutter.find('.shutter-btn .prev');
      this.$nextBtn = this.$shutter.find('.shutter-btn .next');
      this.$shutterNav = this.$shutter.find('.shutter-nav li');
      this.$shutterDesc = this.$shutter.find('.shutter-desc');

      this.shutterItem_len = this.$shutterItem.length;
      this.curDisplay = this.opts.curDisplay > this.shutterItem_len - 1 ? this.opts.curDisplay = this.shutterItem_len - 1 : this.opts.curDisplay;
      this.b_stop = true;
      this.shutterTitle = '';
      this.playTime = null;

      this.initalShutter();

      this.shutterW = this.$shutter.width();
      this.shutterH = this.$shutter.height();

      this.$prevBtn.bind('click', function () {
        if (self.b_stop) {
          self.b_stop = false;

          self.toggleMove('prev');
        }        
      });
      this.$nextBtn.bind('click', function () {
        if (self.b_stop) {
          self.b_stop = false;

          self.toggleMove('next');
          self.$shutterDesc.animate({bottom: -36});
        }
      });

      if (this.opts.fullPage) {
        $(window).resize(function () {
          setTimeout(function () {
            self.$shutter.css({width: $(this).width(), height: $(this).height()});

            self.shutterW = self.$shutter.width();
            self.shutterH = self.$shutter.height();
          }, 30);
        });
      }


      this.play();
      this.$shutter.hover(function () {
        clearInterval(self.playTime);
      }, function () {
        self.play();
      });
    },


    // 图片切换方法
    recovery: function (target, cur, index, backup, interval) {
      var self = this;

      setTimeout(function () {
        target.css('zIndex', 20);
        cur.css('zIndex', self.curDisplay).html(backup);
        self.curDisplay = index;
        self.$shutterDesc.animate({bottom: 0}).find('p').text(self.shutterTitle);

        self.b_stop = true;
      }, interval);
    },

    gridWhole: function (index, showNum) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var $createElem = $('<div class="created"></div>');
      var movingVal = 0;

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      $createElem.html(backup).css({
        position: 'absolute',
        zIndex: 20,
        left: 0,
        top: 0,
        overflow: 'hidden',
        width: this.shutterW,
        height: this.shutterH
      });

      $curElem.append($createElem);

      if (showNum === 0) {
        movingVal = this.shutterW;

        $createElem.velocity({left: movingVal}, {duration: 1000});
      } else if (showNum === 1) {
        movingVal = -this.shutterW;

        $createElem.velocity({left: movingVal}, {duration: 1000});
      } else if (showNum === 2) {
        movingVal = this.shutterH;

        $createElem.velocity({top: movingVal}, {duration: 1000});
      } else if (showNum === 3) {
        movingVal = -this.shutterH;

        $createElem.velocity({top: movingVal}, {duration: 1000});
      }

      $createElem.find('img').css({
        display: 'block',
        width: this.shutterW,
        height: this.shutterH
      });

      this.recovery($targetElem, $curElem, index, backup, 1200);
    },

    gridTop: function (index, showNum) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var speed = 0;

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      for (var i = 0; i < 12; i ++) {
        var $createElem = $('<div class="created"></div>');

        $createElem.html(backup).css({
          position: 'absolute',
          zIndex: 20,
          left: this.shutterW / 12 * i,
          top: 0,
          overflow: 'hidden',
          width: this.shutterW / 12,
          height: this.shutterH
        });

        $curElem.append($createElem);

        $createElem.find('img').css({
          display: 'block',
          width: this.shutterW,
          height: this.shutterH,
          marginLeft: this.shutterW / -12 * i
        });
      }

      if (showNum === 0) {
        var movingVal = 0;

        $curElem.find('.created').each(function (i) {
          if (i % 2 === 0) {
            movingVal = self.shutterH;
          } else {
            movingVal = -self.shutterH;
          }

          $(this).velocity({top: movingVal}, {duration: 1000});
        });
      } else if (showNum === 1) {
        $curElem.find('.created').each(function (i) {
          speed = 80 * i;

          $(this).velocity({top: $(this).height()}, {duration: 120 + speed});
        });
      } else if (showNum === 2) {
        $curElem.find('.created').each(function (i) {
          speed = 80 * i;

          $(this).velocity({top: -$(this).height()}, {duration: 120 + speed});
        });
      }

      this.recovery($targetElem, $curElem, index, backup, 1000);
    },

    gridLeft: function (index, showNum) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var speed = 0;

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      for (var i = 0; i < 12; i ++) {
        var $createElem = $('<div class="created"></div>');

        $createElem.html(backup).css({
          position: 'absolute',
          zIndex: 20,
          left: 0,
          top: this.shutterH / 12 * i,
          overflow: 'hidden',
          width: this.shutterW,
          height: this.shutterH / 12
        });

        $curElem.append($createElem);

        $createElem.find('img').css({
          display: 'block',
          width: this.shutterW,
          height: this.shutterH,
          marginTop: this.shutterH / -12 * i
        });
      }

      if (showNum === 0) {
        var movingVal = 0;

        $curElem.find('.created').each(function (i) {
          if (i % 2 === 0) {
            movingVal = self.shutterW;
          } else {
            movingVal = -self.shutterW;
          }

          $(this).velocity({left: movingVal}, {duration: 1000});
        });
      } else if (showNum === 1) {
        $curElem.find('.created').each(function (i) {
          speed = 80 * i;

          $(this).velocity({left: $(this).width()}, {duration: 120 + speed});
        });
      } else if (showNum === 2) {
        $curElem.find('.created').each(function (i) {
          speed = 80 * i;

          $(this).velocity({left: -$(this).width()}, {duration: 120 + speed});
        });
      }

      this.recovery($targetElem, $curElem, index, backup, 1000);
    },

    gridOpacity: function (index) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var $createElem = $('<div class="created"></div>');

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      $createElem.html(backup).css({
        position: 'absolute',
        zIndex: 20,
        left: 0,
        top: 0,
        overflow: 'hidden',
        width: this.shutterW,
        height: this.shutterH,
        opacity: 1
      });

      $createElem.find('img').css({
        display: 'block',
        width: this.shutterW,
        height: this.shutterH
      });

      $curElem.append($createElem);

      $createElem.velocity({opacity: 0}, {duration: 1000});

      this.recovery($targetElem, $curElem, index, backup, 1000);
    },

    gridAccordion: function (index) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var iNow = 0;
      var speed = 0;

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      for (var i = 0; i < 12; i ++) {
        var $createElem = $('<div class="created"></div>');

        $createElem.html(backup).css({
          position: 'absolute',
          zIndex: 20,
          left: this.shutterW / 12 * i,
          top: 0,
          overflow: 'hidden',
          width: this.shutterW / 12,
          height: this.shutterH,
          opacity: 1
        });

        $curElem.append($createElem);

        $createElem.find('img').css({
          display: 'block',
          width: this.shutterW,
          height: this.shutterH,
          marginLeft: this.shutterW / -12 * i
        });
      }

      $curElem.find('.created').each(function (i) {
        speed = i * 80;

        $(this).velocity({opacity: 0}, {duration: 320 + speed});
      });

      this.recovery($targetElem, $curElem, index, backup, 1200);
    },

    gridLittle: function (index) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();
      var coordinate = null;

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      for (var i = 0; i < 24; i ++) {
        var $createElem = $('<div class="created"></div>');

        $createElem.html(backup).css({
          width: this.shutterW / 6,
          height: this.shutterH / 4,
          left: (this.shutterW / 6) * (i % 6),
          top: (this.shutterH / 4) * Math.floor(i / 6)
        });

        $curElem.append($createElem);

        $createElem.find('img').css({
          display: 'block',
          width: this.shutterW,
          height: this.shutterH,
          marginLeft: -(this.shutterW / 6) * (i % 6),
          marginTop: -(this.shutterH / 4) * Math.floor(i / 6)
        });
      }

      coordinate = getXY($curElem.find('.created'), 4, 6);

      tab(coordinate, 0, 0, function () {
        var left = parseInt(this.style.left);
        var top = parseInt(this.style.top);

        $(this).velocity({
          left: left + 100,
          top: top + 100,
          opacity: 0
        });
      }, 100, +1, +1);

      this.recovery($targetElem, $curElem, index, backup, 1200);
    },

    gridSwitch: function (index) {
      var self = this;
      var $curElem = this.$shutterItem.eq(this.curDisplay);
      var $targetElem = this.$shutterItem.eq(index);
      var backup = $curElem.html();

      $targetElem.css('zIndex', 19);
      $curElem.find('img').fadeOut();

      for (var i = 0; i < 20; i ++) {
        var $createElem = $('<div class="created"></div>');

        $createElem.html(backup).css({
          width: this.shutterW / 5,
          height: this.shutterH / 4,
          left: (this.shutterW / 5) * (i % 5),
          top: (this.shutterH / 4) * Math.floor(i / 5)
        });

        $curElem.append($createElem);

        $createElem.find('img').css({
          display: 'block',
          width: this.shutterW,
          height: this.shutterH,
          marginLeft: -(this.shutterW / 5) * (i % 5),
          marginTop: -(this.shutterH / 4) * Math.floor(i / 5)
        });
      }

      $curElem.find('.created').each(function (i) {
        if (i % 2 === 0) {
          $(this).find('img').velocity({
            marginLeft: $(this).width()
          }, {duration: 500});
        }
      });

      setTimeout(function () {
        $curElem.find('.created').each(function (i) {
          if (i % 1 === 0) {
            $(this).find('img').velocity({
              marginLeft: $(this).width()
            }, {duration: 500});
          }
        });
      }, 600);

      this.recovery($targetElem, $curElem, index, backup, 1200);
    },

    constructor: Shutter
  };

  $.fn.shutter = function (options) {
    this.each(function () {
      var shutter = new Shutter($(this), options);
    });
  };

})(jQuery, window, document);

function tab(arr, x, y, fn, delay, speedX, speedY) {
  if (!arr[y] || !arr[y][x]) {
    return;
  }

  if (fn) {
    fn.call(arr[y][x]);

    clearTimeout(arr[y][x].timer);
    arr[y][x].timer = setTimeout(function () {
      tab(arr, x, y + speedY, fn, delay, speedX, speedY);
      tab(arr, x + speedX, y, fn, delay, speedX, speedY);
    }, delay);
  }
};

function getXY(objs, rows, cols) {
  var arr1 = [];

  for (var i = 0; i < rows; i ++) {
    var arr2 = [];

    for (var j = 0; j < cols; j ++) {
      objs[i * cols + j].xIndex = j;
      objs[i * cols + j].yIndex = i;

      arr2.push(objs[i * cols + j]);
    }

    arr1.push(arr2);
  }

  return arr1;
};