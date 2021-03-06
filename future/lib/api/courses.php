<?php

/****************************************************************
 *
 *  Copyright 2010 The President and Fellows of Harvard College
 *  Copyright 2010 Modo Labs Inc.
 *
 *****************************************************************/

require_once realpath(LIB_DIR.'/api.php');
require_once realpath(LIB_DIR.'/feeds/courses.php');

$command = apiGetArg('command');

switch ($command) {
  case 'courses':
    $data = CourseData::get_schoolsAndCourses();
    
    // native apps can't handle empty course lists and need fake 'short' name
    foreach ($data as $i => $schoolData) {
      $newCoursesArray = array();
      foreach ($schoolData['courses'] as $courseName) {
        $newCoursesArray[] = array(
          'name'  => $courseName,
          'short' => '1',
        );
      }
      $data[$i]['courses'] = $newCoursesArray;
    }
    break;
  
  case 'subjectList':
    $course = apiGetArg('id');
    $school = apiGetArg('coursegroup');
    $data = CourseData::get_subjectsForCourse($course, $school);
    
    if (isset($_REQUEST['checksum'])) {
      $checksum = md5(json_encode($data));
      if (isset($_REQUEST['full'])) {
        $data = array('checksum' => $checksum, 'classes' => $data);
      }
      else {
        $data = array('checksum' => $checksum);
      }
    }
    break;
    
  case 'term':
    $data = array('term' => CourseData::get_term());
    break;
  
  case 'subjectInfo':
    $subjectId = apiGetArg('id');
    $data = CourseData::get_subject_details($subjectId);
    if(!$data) {
      $data = array('error' => 'SubjectNotFound', 'message' => 'Courses could not find this subject');
    }
    // If parsed_meeting_times is not NULL, then the iPhone can be smart about
    // handling multiple locations and times.  Otherwise, we fall back on the
    // old behavior of just assuming it's one location and one time being sent.
    $data['parsed_meeting_times'] = $data['meeting_times']->toArray();
    break;
  
  case 'search':
    $query = apiGetArg('query');
    $school = apiGetArg('courseGroup');
    $course = apiGetArg('courseName');
  
    $data = CourseData::search_subjects($query, $school, $course);
    break;
}

echo json_encode($data);
