module.exports = function(grunt) {
    var banner = '/*n<%= pkg.name %> <%= pkg.version %>';
    banner += '- <%= pkg.description %>n<%= pkg.repository.url %>n';
    banner += 'Built on <%= grunt.template.today("yyyy-mm-dd") %>n*/n';

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        eslint: {
            files: ['test_modules/*.js', 'test_modules/**/*.js'],
        },
        simplemocha: {
            options: {
                globals: ['expect'],
                timeout: 3000,
                ignoreLeaks: false,
                ui: 'bdd',
                reporter: 'tap'
            },
            all: { src: ['tests/*.js'] }
        },
        watch: {
            scripts: {
                files: ['test_modules/*.js', 'test_modules/**/*.js', 'tests/**/*.js'],
                tasks: ['dev']
            }
        }
    });

    grunt.loadNpmTasks('grunt-eslint');
    grunt.loadNpmTasks('grunt-simple-mocha');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('dev', 
        ['eslint', 'simplemocha']);
};