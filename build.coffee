# setup #
cmd = require 'node-cmd'
path = require 'path'
fs = require 'fs'
clr = require 'cli-color'

# write functions
module.exports =
    findCommand = (filename, command) ->
        ret = filename.replace("[fn]", filename)
        return ret
    fromDir = (startPath, filter, addTo) ->
        console.log('[GETFILES] Starting from dir '+startPath+'/');
        if !fs.existsSync(startPath)
            throw clr.'[GETFILES][ERROR] No directory provided. '+ startPath
            return
        files = fs.readdirSync(startPath)
        i = 0
        while i < files.length
            filename = path.join(startPath, files[i])
            stat = fs.lstatSync(filename)
            if filename isnt __filename
                if stat.isDirectory()
                    fromDir filename, filter
                    #recurse
                else if filename.indexOf(filter) >= 0
                    console.log '[GETFILES] Found: '+ filename
                    # push filename to file array #
                    addTo.push filename
                    console.log '[GETFILES] Pushed ' + filename + ' to array'
                    console.log '[GETFILES] Files to compile: '+addTo
            i++
        return
    compileFiles = (list) ->
        for i in list
            console.log clr.yellow '[DEBUG][COMPILEFILES] Will run command: "'+'coffee -c '+ i+'"'
            cmd.run('coffee -c ""'+i+'"')        
    