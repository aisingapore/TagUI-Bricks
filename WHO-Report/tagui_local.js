function get_china_stats() {
    var c_stats = pdf_result.substring(pdf_result.indexOf('SITUATION IN NUMBERS'), pdf_result.indexOf('WHO RISK ASSESSMENT'))
    c_stats = c_stats.substring(c_stats.indexOf('China')+5)
    c_stats = c_stats.substring(0, c_stats.indexOf(' new)')+5).trim()
    var c_total = c_stats.substring(0, c_stats.indexOf(' confirmed'))
    var c_new = c_stats.substring(c_stats.indexOf('confirmed (')+11, c_stats.indexOf(' new)'))
    return {name: 'China', stats: c_total + ' (' + c_new + ')'}
}

function next_country_stats() {
    var country_result = ''; var country_name = ''; var country_stats = ''; 
    var country_index = 0; var country_position = 99999;
    for (n = 0; n <= country_list.length-1; n++)
    {
        if ((pdf_result.indexOf(country_list[n]) < country_position)
        && (pdf_result.indexOf(country_list[n]) > -1))
        {
            country_index = n
            country_position = pdf_result.indexOf(country_list[n])
        }
    }
    pdf_result = pdf_result.substr(country_position).trim()

    if (country_list[country_index] !== 'International conveyance (Japan)')
    {
        var country_index2 = 0; var country_position2 = 99999;
        for (n = 0; n <= country_list.length-1; n++)
        {
            if ((pdf_result.indexOf(country_list[n]) < country_position2)
            && (pdf_result.indexOf(country_list[n]) > -1) && (pdf_result.indexOf(country_list[n]) > country_position))
            {
                country_index2 = n
                country_position2 = pdf_result.indexOf(country_list[n])
            }
        }
        country_result = pdf_result.substring(0, country_position2).trim()
        pdf_result = pdf_result.substr(country_position2).trim()
    }
    else
    {
        country_result = pdf_result
    }

    country_name = country_list[country_index]
    country_stats = country_result.substr(country_name.length).trim()
    total_stats = country_stats.substring(0, country_stats.indexOf(' '))
    new_stats = country_stats.substr(total_stats.length).trim()
    new_stats = new_stats.substring(0, new_stats.indexOf(' '))
    country_stats = total_stats + ' (' + new_stats  + ')'
    return {name: country_name, stats: country_stats}
}
