javascript:void((function() {

var gua_g = {
    expand_all: function(file_id) {
        var $exps;
        if (typeof file_id === 'undefined') {
            $exps = $('.diff-expander');
        } else {
            $exps = $('#'+file_id+' .diff-expander');
        }
        if ($exps.length > 0) {
            $exps.click();
            console.debug('has some len=' + $exps.length+' file_id='+file_id);
            setTimeout(
                function() {
                    gua_g.expand_all(file_id);
                },
                500);
        } else {
            console.debug('done');
        }
    },
    launch: function() {
        $('.file').each(function(i, el) {
            var $f = $(el);
            var file_id = $f.attr('id');
            var $b = $('<button/>');
            $b.text('++');
            $b.on('click', function() {
                gua_g.expand_all(file_id);
                $(this).remove();
            });
            $f.find('.info').append($b);
        });
    }
};
gua_g.launch();

})())
